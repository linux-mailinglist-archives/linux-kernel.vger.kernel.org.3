Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782794D1F7C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349319AbiCHRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349307AbiCHRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:54:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F954522CC;
        Tue,  8 Mar 2022 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646762018; x=1678298018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qitj4I97KQMnsVuQMFTQ4a/o8fe2e11Qx63wNu3uOQg=;
  b=BHejLsn6eVeLqWHucdfk0WcwGZZ/paRmu92Vq4u54F8WOSStQ9i2xEv9
   KhS7VR3KX/X4c+QTg3JRk5V16DPJo5bBB++PG8jZzUaT39B+Jj10690yG
   lPLP/Nwq2g70kfI2p3DjYTOR2RObdXgk3R4fizo9FaV522KXOBi042c38
   Lefdgxc4EFsUBXxV/r7bFmoJ8MDqUTkS8RAdlFtXim9WiXugu4Ytmxn0O
   akDgyLvSef7Dpkly1tZoeJLLU0ET+eUqXIx+FKvQQRyjUTUuzk6+66UNY
   kQr/+xYrUwtJGXBGglvT7C4BkxqKr9U/W4RerouHVfTIt1cv9G57j1q2u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252337403"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="252337403"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="513204302"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 09:53:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRe1d-0001mg-QU; Tue, 08 Mar 2022 17:53:33 +0000
Date:   Wed, 9 Mar 2022 01:52:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     kbuild-all@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] pata_parport: add core driver (PARIDE replacement)
Message-ID: <202203090134.f9NhVHMa-lkp@intel.com>
References: <20220305201411.501-2-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305201411.501-2-linux@zary.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hch-configfs/for-next]
[also build test WARNING on linux/master linus/master v5.17-rc7 next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ondrej-Zary/pata_parport-add-core-driver-PARIDE-replacement/20220307-142912
base:   git://git.infradead.org/users/hch/configfs.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220309/202203090134.f9NhVHMa-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/05539e2a04721c2710e7d1f6ae49926474bdf918
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ondrej-Zary/pata_parport-add-core-driver-PARIDE-replacement/20220307-142912
        git checkout 05539e2a04721c2710e7d1f6ae49926474bdf918
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/ata/pata_parport/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ata/pata_parport/pata_parport.c:341:6: warning: no previous prototype for 'pi_release' [-Wmissing-prototypes]
     341 | void pi_release(struct pi_adapter *pi)
         |      ^~~~~~~~~~
>> drivers/ata/pata_parport/pata_parport.c:462:6: warning: no previous prototype for 'pata_parport_bus_release' [-Wmissing-prototypes]
     462 | void pata_parport_bus_release(struct device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ata/pata_parport/pata_parport.c:476:20: warning: no previous prototype for 'pi_init_one' [-Wmissing-prototypes]
     476 | struct pi_adapter *pi_init_one(struct parport *parport, struct pi_protocol *pr,
         |                    ^~~~~~~~~~~


vim +/pi_release +341 drivers/ata/pata_parport/pata_parport.c

   340	
 > 341	void pi_release(struct pi_adapter *pi)
   342	{
   343		parport_unregister_device(pi->pardev);
   344		if (pi->proto->release_proto)
   345			pi->proto->release_proto(pi);
   346		module_put(pi->proto->owner);
   347	}
   348	
   349	static int default_test_proto(struct pi_adapter *pi, char *scratch)
   350	{
   351		int j, k;
   352		int e[2] = { 0, 0 };
   353	
   354		pi->proto->connect(pi);
   355	
   356		for (j = 0; j < 2; j++) {
   357			pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
   358			for (k = 0; k < 256; k++) {
   359				pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
   360				pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
   361				if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
   362					e[j]++;
   363			}
   364		}
   365		pi->proto->disconnect(pi);
   366	
   367		if (verbose)
   368			dev_info(&pi->dev, "%s: port 0x%x, mode  %d, test=(%d,%d)\n",
   369			       pi->proto->name, pi->port,
   370			       pi->mode, e[0], e[1]);
   371	
   372		return (e[0] && e[1]);	/* not here if both > 0 */
   373	}
   374	
   375	static int pi_test_proto(struct pi_adapter *pi, char *scratch)
   376	{
   377		int res;
   378	
   379		parport_claim_or_block(pi->pardev);
   380		if (pi->proto->test_proto)
   381			res = pi->proto->test_proto(pi, scratch, verbose);
   382		else
   383			res = default_test_proto(pi, scratch);
   384		parport_release(pi->pardev);
   385	
   386		return res;
   387	}
   388	
   389	static int pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
   390	{
   391		int best, range;
   392	
   393		if (pi->mode != -1) {
   394			if (pi->mode >= max)
   395				return 0;
   396			range = 3;
   397			if (pi->mode >= pi->proto->epp_first)
   398				range = 8;
   399			if ((range == 8) && (pi->port % 8))
   400				return 0;
   401			return (!pi_test_proto(pi, scratch));
   402		}
   403		best = -1;
   404		for (pi->mode = 0; pi->mode < max; pi->mode++) {
   405			range = 3;
   406			if (pi->mode >= pi->proto->epp_first)
   407				range = 8;
   408			if ((range == 8) && (pi->port % 8))
   409				break;
   410			if (!pi_test_proto(pi, scratch))
   411				best = pi->mode;
   412		}
   413		pi->mode = best;
   414		return (best > -1);
   415	}
   416	
   417	
   418	static int pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)
   419	{
   420		int max, s, e;
   421	
   422		s = unit;
   423		e = s + 1;
   424	
   425		if (s == -1) {
   426			s = 0;
   427			e = pi->proto->max_units;
   428		}
   429	
   430		if (pi->proto->test_port) {
   431			parport_claim_or_block(pi->pardev);
   432			max = pi->proto->test_port(pi);
   433			parport_release(pi->pardev);
   434		} else
   435			max = pi->proto->max_mode;
   436	
   437		if (pi->proto->probe_unit) {
   438			parport_claim_or_block(pi->pardev);
   439			for (pi->unit = s; pi->unit < e; pi->unit++)
   440				if (pi->proto->probe_unit(pi)) {
   441					parport_release(pi->pardev);
   442					if (pi_probe_mode(pi, max, scratch))
   443						return 1;
   444					return 0;
   445				}
   446			parport_release(pi->pardev);
   447			return 0;
   448		}
   449	
   450		if (!pi_probe_mode(pi, max, scratch))
   451			return 0;
   452		return 1;
   453	}
   454	
   455	static void pata_parport_dev_release(struct device *dev)
   456	{
   457		struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
   458	
   459		kfree(pi);
   460	}
   461	
 > 462	void pata_parport_bus_release(struct device *dev)
   463	{
   464		/* nothing to do here but required to avoid warning on device removal */
   465	}
   466	
   467	static struct bus_type pata_parport_bus_type = {
   468		.name = DRV_NAME,
   469	};
   470	
   471	static struct device pata_parport_bus = {
   472		.init_name = DRV_NAME,
   473		.release = pata_parport_bus_release,
   474	};
   475	
 > 476	struct pi_adapter *pi_init_one(struct parport *parport, struct pi_protocol *pr,
   477				       int mode, int unit, int delay)
   478	{
   479		struct pardev_cb par_cb = { };
   480		char scratch[512];
   481		const struct ata_port_info *ppi[] = { &pata_parport_port_info };
   482		struct ata_host *host;
   483		struct pi_adapter *pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
   484	
   485		if (!pi)
   486			return NULL;
   487	
   488		/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
   489		pi->dev.parent = &pata_parport_bus;
   490		pi->dev.bus = &pata_parport_bus_type;
   491		pi->dev.driver = &pr->driver;
   492		pi->dev.release = pata_parport_dev_release;
   493		pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
   494		if (pi->dev.id < 0)
   495			return NULL; /* pata_parport_dev_release will do kfree(pi) */
   496		dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
   497		if (device_register(&pi->dev)) {
   498			put_device(&pi->dev);
   499			goto out_ida_free;
   500		}
   501	
   502		pi->proto = pr;
   503	
   504		/* still racy */
   505		if (!try_module_get(pi->proto->owner))
   506			goto out_unreg_dev;
   507		if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
   508			goto out_module_put;
   509	
   510		pi->delay = (delay == -1) ? pi->proto->default_delay : delay;
   511		pi->mode = mode;
   512		pi->port = parport->base;
   513	
   514		par_cb.private = pi;
   515		pi->pardev = parport_register_dev_model(parport, dev_name(&pi->dev),
   516							&par_cb, pi->dev.id);
   517		if (!pi->pardev)
   518			goto out_module_put;
   519	
   520		if (!pi_probe_unit(pi, unit, scratch)) {
   521			dev_info(&pi->dev, "Adapter not found\n");
   522			goto out_unreg_parport;
   523		}
   524	
   525		pi->proto->log_adapter(pi, scratch, verbose);
   526	
   527		host = ata_host_alloc_pinfo(&pi->dev, ppi, 1);
   528		if (!host)
   529			goto out_unreg_parport;
   530		dev_set_drvdata(&pi->dev, host);
   531		host->private_data = pi;
   532	
   533		ata_port_desc(host->ports[0], "port %s", pi->pardev->port->name);
   534		ata_port_desc(host->ports[0], "protocol %s", pi->proto->name);
   535	
   536		timer_setup(&pi->timer, pi_disconnect_timer, 0);
   537	
   538		if (ata_host_activate(host, 0, NULL, 0, &pi->proto->sht))
   539			goto out_unreg_parport;
   540	
   541		return pi;
   542	
   543	out_unreg_parport:
   544		parport_unregister_device(pi->pardev);
   545		if (pi->proto->release_proto)
   546			pi->proto->release_proto(pi);
   547	out_module_put:
   548		module_put(pi->proto->owner);
   549	out_unreg_dev:
   550		device_unregister(&pi->dev);
   551	out_ida_free:
   552		ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
   553		return NULL;
   554	}
   555	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
