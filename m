Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931CF511DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiD0RmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbiD0RmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:42:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287960AB5;
        Wed, 27 Apr 2022 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651081131; x=1682617131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NMm02wlbN4k54YDbhpLslvrOvR9BUhjMu9kb0eqP1oE=;
  b=iabKDRf5r6Med6DyYRcDyjDqhT1w122fYNbw/05809aQzvj4sp2Qcv5u
   O4WfhhO2uhwSSHRP5RtV+dZz/nFfIR5rBwqndaqN+GMHGv0D1P5ENMVhj
   mpP61fXfpWtO4fr3HTgtzoxH2+gUGPZtf5WA9YIdgzAb3O7eAzWdNdE5U
   9dFXPrjycKzikJC1uQrXdiIW4S9AblVWXFvxMV2Tfb44vIj5Fkw9aOKUU
   C18wYfiHQ17hu2T9apSmZ8Gcgs8Lnm1XQim9LgvsEm7F8ZA0btRyfSy+c
   b6+K4d0uyJotrTmsc303pdnGUaQPe0s9LByN4uD3JJkvPI0yfMH/0oLbw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246574166"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="246574166"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 10:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="876762002"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2022 10:38:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njlcd-0004pC-ST;
        Wed, 27 Apr 2022 17:38:39 +0000
Date:   Thu, 28 Apr 2022 01:37:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do
 not exists
Message-ID: <202204280121.ObD8tBkn-lkp@intel.com>
References: <20220427094502.456111-3-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427094502.456111-3-clement.leger@bootlin.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Cl�ment,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on v5.18-rc4 next-20220427]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-L-ger/add-dynamic-PCI-device-of_node-creation-for-overlay/20220427-190828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: microblaze-randconfig-r005-20220427 (https://download.01.org/0day-ci/archive/20220428/202204280121.ObD8tBkn-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/787f8567f04db060522e198fbdc55a805e99b922
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cl-ment-L-ger/add-dynamic-PCI-device-of_node-creation-for-overlay/20220427-190828
        git checkout 787f8567f04db060522e198fbdc55a805e99b922
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/of.c: In function 'of_pci_add_property':
>> drivers/pci/of.c:50:9: error: implicit declaration of function 'of_property_set_flag'; did you mean 'of_node_set_flag'? [-Werror=implicit-function-declaration]
      50 |         of_property_set_flag(prop, OF_DYNAMIC);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         of_node_set_flag
>> drivers/pci/of.c:54:15: error: implicit declaration of function 'of_changeset_add_property'; did you mean 'of_pci_add_property'? [-Werror=implicit-function-declaration]
      54 |         ret = of_changeset_add_property(ocs, np, prop);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~
         |               of_pci_add_property
   drivers/pci/of.c: In function 'of_pci_make_dev_node':
>> drivers/pci/of.c:129:9: error: implicit declaration of function 'of_changeset_init' [-Werror=implicit-function-declaration]
     129 |         of_changeset_init(&cs);
         |         ^~~~~~~~~~~~~~~~~
>> drivers/pci/of.c:147:15: error: implicit declaration of function 'of_changeset_attach_node' [-Werror=implicit-function-declaration]
     147 |         ret = of_changeset_attach_node(&cs, node);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/of.c:151:15: error: implicit declaration of function 'of_changeset_apply' [-Werror=implicit-function-declaration]
     151 |         ret = of_changeset_apply(&cs);
         |               ^~~~~~~~~~~~~~~~~~
>> drivers/pci/of.c:160:9: error: implicit declaration of function 'of_changeset_destroy' [-Werror=implicit-function-declaration]
     160 |         of_changeset_destroy(&cs);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +50 drivers/pci/of.c

    17	
    18	#ifdef CONFIG_PCI
    19	static int of_pci_add_property(struct of_changeset *ocs, struct device_node *np,
    20				       const char *name, const void *value, int length)
    21	{
    22		struct property *prop;
    23		int ret = -ENOMEM;
    24	
    25		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
    26		if (!prop)
    27			return -ENOMEM;
    28	
    29		prop->name = kstrdup(name, GFP_KERNEL);
    30		if (!prop->name)
    31			goto out_err;
    32	
    33		if (value) {
    34			prop->value = kmemdup(value, length, GFP_KERNEL);
    35			if (!prop->value)
    36				goto out_err;
    37		} else {
    38			/*
    39			 * Even if the property has no value, it must be set to a
    40			 * non-null value since of_get_property() is used to check
    41			 * some values that might or not have a values (ranges for
    42			 * instance). Moreover, when the node is released, prop->value
    43			 * is kfreed so the memory must come from kmalloc.
    44			 */
    45			prop->value = kmalloc(1, GFP_KERNEL);
    46			if (!prop->value)
    47				goto out_err;
    48		}
    49	
  > 50		of_property_set_flag(prop, OF_DYNAMIC);
    51	
    52		prop->length = length;
    53	
  > 54		ret = of_changeset_add_property(ocs, np, prop);
    55		if (!ret)
    56			return 0;
    57	
    58	out_err:
    59		kfree(prop->value);
    60		kfree(prop->name);
    61		kfree(prop);
    62	
    63		return ret;
    64	}
    65	
    66	static struct device_node *of_pci_make_node(void)
    67	{
    68		struct device_node *node;
    69	
    70		node = kzalloc(sizeof(*node), GFP_KERNEL);
    71		if (!node)
    72			return NULL;
    73	
    74		of_node_set_flag(node, OF_DYNAMIC);
    75		of_node_set_flag(node, OF_DETACHED);
    76		of_node_init(node);
    77	
    78		return node;
    79	}
    80	
    81	static int of_pci_add_cells_props(struct device_node *node,
    82					  struct of_changeset *cs, int n_addr_cells,
    83					  int n_size_cells)
    84	{
    85		__be32 val;
    86		int ret;
    87	
    88		ret = of_pci_add_property(cs, node, "ranges", NULL, 0);
    89		if (ret)
    90			return ret;
    91	
    92		val = __cpu_to_be32(n_addr_cells);
    93		ret = of_pci_add_property(cs, node, "#address-cells", &val,
    94					  sizeof(__be32));
    95		if (ret)
    96			return ret;
    97	
    98		val = __cpu_to_be32(n_size_cells);
    99		return of_pci_add_property(cs, node, "#size-cells", &val,
   100					   sizeof(__be32));
   101	}
   102	
   103	static int of_pci_add_pci_bus_props(struct device_node *node,
   104					    struct of_changeset *cs)
   105	{
   106		int ret;
   107	
   108		ret = of_pci_add_property(cs, node, "device_type", "pci",
   109					  strlen("pci") + 1);
   110		if (ret)
   111			return ret;
   112	
   113		return of_pci_add_cells_props(node, cs, 3, 2);
   114	}
   115	
   116	static void of_pci_make_dev_node(struct pci_dev *dev)
   117	{
   118		static struct of_changeset cs;
   119		const char *pci_type = "dev";
   120		struct device_node *node;
   121		__be32 val[5] = {0};
   122		int ret;
   123	
   124		node = of_pci_make_node();
   125		if (!node)
   126			return;
   127	
   128		node->parent = dev->bus->dev.of_node;
 > 129		of_changeset_init(&cs);
   130	
   131		if (pci_is_bridge(dev)) {
   132			ret = of_pci_add_pci_bus_props(node, &cs);
   133			if (ret)
   134				goto changeset_destroy;
   135			pci_type = "pci";
   136		}
   137	
   138		node->full_name = kasprintf(GFP_KERNEL, "%s@%x,%x", pci_type,
   139					    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
   140	
   141		val[0] = __cpu_to_be32(dev->devfn << 8);
   142		val[4] = __cpu_to_be32(SZ_4K);
   143		ret = of_pci_add_property(&cs, node, "reg", val, 5 * sizeof(__be32));
   144		if (ret)
   145			goto changeset_destroy;
   146	
 > 147		ret = of_changeset_attach_node(&cs, node);
   148		if (ret)
   149			goto changeset_destroy;
   150	
 > 151		ret = of_changeset_apply(&cs);
   152		if (ret)
   153			goto changeset_destroy;
   154	
   155		dev->dev.of_node = node;
   156	
   157		return;
   158	
   159	changeset_destroy:
 > 160		of_changeset_destroy(&cs);
   161		kfree(node);
   162	}
   163	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
