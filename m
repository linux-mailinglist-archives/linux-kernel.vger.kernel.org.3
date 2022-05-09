Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3551F265
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiEIBbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiEIA3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 20:29:53 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75167663
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 17:25:59 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BEE878209D;
        Mon,  9 May 2022 02:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652055956;
        bh=IC6HtACtxaNOv2PNkGQVyQk9T3ik9WinMG8LB9UQtUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zLkDm04wTHaqGRE9Y54uCDxs/ZJIdG9qin1zf+VmqTEQ5zcFpSSo3Brin9GX5Imx5
         EsHVLENGnj+sHkh/ptqXckSM4dZW0LAFirC7n4s571QpyHsaaIUX9SsMamy5G4PdQ0
         Rt+NUfdSkuZvAi1B/O5UBJ8xTkMqMANQrEY8S0ZurDTWw3IkGViR3F3st/c2lk9xAt
         4lhEeYO36sBygze2fyJ46C0vZo0Ew88Pcu07ynGIoDuKJ38USdlVbc3X/wPpP9oZbi
         OgJsSj8lMvNIcrAOwdki9v6heLKsVNsc15ziMol9+IuigA+ZJSi85PfQU4Lbi8X/pl
         j+KkdTuQwy7Ag==
Message-ID: <f2b04356-c08b-4e44-4552-1fa6ee94ceba@denx.de>
Date:   Mon, 9 May 2022 02:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re:
 [broonie-ci:20220430_marex_regmap_add_bulk_read_write_callbacks_into_regmap_config
 1/1] drivers/base/regmap/regmap.c:1842 _regmap_raw_write_impl() error: we
 previously assumed 'map->bus' could be null (see line 1770)
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202205060518.hir67qzc-lkp@intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <202205060518.hir67qzc-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 09:12, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git 20220430_marex_regmap_add_bulk_read_write_callbacks_into_regmap_config
> head:   d77e745613680c54708470402e2b623dcd769681
> commit: d77e745613680c54708470402e2b623dcd769681 [1/1] regmap: Add bulk read/write callbacks into regmap_config
> config: m68k-randconfig-m031-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060518.hir67qzc-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/base/regmap/regmap.c:1842 _regmap_raw_write_impl() error: we previously assumed 'map->bus' could be null (see line 1770)
> 
> vim +1842 drivers/base/regmap/regmap.c

[...]

> 0074f3f2b1e43d Colin Foster        2022-03-13  1754  	reg += map->reg_base;
> 86fc59ef818beb Colin Foster        2022-03-13  1755  	reg >>= map->format.reg_downshift;
> d939fb9a78b474 Marc Reilly         2012-03-16  1756  	map->format.format_reg(map->work_buf, reg, map->reg_shift);
> f50e38c9966076 Tony Lindgren       2016-09-15  1757  	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
> f50e38c9966076 Tony Lindgren       2016-09-15  1758  				      map->write_flag_mask);
> 6f306441e97f8f Lars-Peter Clausen  2011-09-05  1759
> 651e013e3ce6c0 Mark Brown          2013-10-08  1760  	/*
> 651e013e3ce6c0 Mark Brown          2013-10-08  1761  	 * Essentially all I/O mechanisms will be faster with a single
> 651e013e3ce6c0 Mark Brown          2013-10-08  1762  	 * buffer to write.  Since register syncs often generate raw
> 651e013e3ce6c0 Mark Brown          2013-10-08  1763  	 * writes of single registers optimise that case.
> 651e013e3ce6c0 Mark Brown          2013-10-08  1764  	 */
> 651e013e3ce6c0 Mark Brown          2013-10-08  1765  	if (val != work_val && val_len == map->format.val_bytes) {
> 651e013e3ce6c0 Mark Brown          2013-10-08  1766  		memcpy(work_val, val, map->format.val_bytes);
> 651e013e3ce6c0 Mark Brown          2013-10-08  1767  		val = work_val;
> 651e013e3ce6c0 Mark Brown          2013-10-08  1768  	}
> 651e013e3ce6c0 Mark Brown          2013-10-08  1769
> d77e745613680c Marek Vasut         2022-04-30 @1770  	if (map->async && map->bus && map->bus->async_write) {
>                                                                            ^^^^^^^^
> Do we really need to check map->bus?

Here I think so, because bus can be NULL.

[...]

> c6b570d97c0e77 Philipp Zabel       2015-03-09  1831  	trace_regmap_hw_write_start(map, reg, val_len / map->format.val_bytes);
> fb2736bbaee0e7 Mark Brown          2011-07-24  1832
> 2547e201b3693f Mark Brown          2011-07-20  1833  	/* If we're doing a single register write we can probably just
> 2547e201b3693f Mark Brown          2011-07-20  1834  	 * send the work_buf directly, otherwise try to do a gather
> 2547e201b3693f Mark Brown          2011-07-20  1835  	 * write.
> 2547e201b3693f Mark Brown          2011-07-20  1836  	 */
> 0d509f2b112b21 Mark Brown          2013-01-27  1837  	if (val == work_val)
> d77e745613680c Marek Vasut         2022-04-30  1838  		ret = map->write(map->bus_context, map->work_buf,
> 82159ba8e6ef8c Mark Brown          2012-01-18  1839  				 map->format.reg_bytes +
> 82159ba8e6ef8c Mark Brown          2012-01-18  1840  				 map->format.pad_bytes +
> 82159ba8e6ef8c Mark Brown          2012-01-18  1841  				 val_len);
> 2547e201b3693f Mark Brown          2011-07-20 @1842  	else if (map->bus->gather_write)
>                                                                   ^^^^^^^^
> It's not checked here

This is a bug indeed.
