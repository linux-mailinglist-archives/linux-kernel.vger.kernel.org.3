Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102CC5AFC1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIGGIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGGIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:08:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFA8D3CE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93933B81AAA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CED4C433C1;
        Wed,  7 Sep 2022 06:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662530893;
        bh=54fvH7VDRvsGmh4xj/BwuuP8XcmMrbqIP4PH3zgeTFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgtAetD9hwCH2h7eUABYqWhstWrcoH/w9y14eL34cVoVRv92lA3Jga4NGwjNLUcvR
         yOTwQPyUR1Xnfns3DlL3i8Ntt51dqEoqiS9Dr0z6kxLz5aKYZRNkMN+Err7OdYmSzC
         z3gk0jfg6N5Q8BDp2/Vb+ngQMrAYfNEsHLWG+a/s=
Date:   Wed, 7 Sep 2022 08:08:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc:char-misc-next 21/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse: sparse:
 symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it be
 static?
Message-ID: <Yxg1SADGQaJ6jGiY@kroah.com>
References: <202209051441.knwv3o1D-lkp@intel.com>
 <BN8PR11MB3668B1EAD67AFB7CB5CCB6C2E97E9@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB3668B1EAD67AFB7CB5CCB6C2E97E9@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 06:02:22PM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > -----Original Message-----
> > From: kernel test robot <lkp@intel.com>
> > Sent: Monday, September 5, 2022 12:07 PM
> > To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> > Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Greg Kroah-
> > Hartman <gregkh@linuxfoundation.org>
> > Subject: [char-misc:char-misc-next 21/24]
> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse: sparse:
> > symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it be
> > static?
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > char-misc-next
> > head:   50e177c5bfd9abc3828cb57e14e6169170f6764a
> > commit: 7d3e4d807df2a216b9aa2944372f2b3f6ef3f205 [21/24] misc:
> > microchip: pci1xxxx: load gpio driver for the gpio controller auxiliary device
> > enumerated by the auxiliary bus driver.
> > config: i386-randconfig-s033-20220905
> > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> .
> .
> .
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:135:34: sparse:
> > sparse: symbol 'pci1xxxx_gpio_auxiliary_id_table' was not declared. Should it
> > be static?
> Greg, do I need to submit another patch to resolve this warning on char-misc-next?
> I did not combine this with the last patch thinking that the last patch would
> be merged with the commit that introduced the errors and not queued.

No, I can't merge it into an older commit as those branches can never be
rebased.

Please send a new fix for this issue as well.

thanks,

greg k-h
