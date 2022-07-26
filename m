Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF39D581718
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiGZQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiGZQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:15:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF921E37;
        Tue, 26 Jul 2022 09:15:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v13so13077275wru.12;
        Tue, 26 Jul 2022 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2CYBMsmQbgF+TXkPvlVXR2XIGR882kaI72ZjOlmcwgM=;
        b=LDu7H51gflrqODW7Flg/dy0LvcWzxBxIN4+J2cpKytkTgZrtoZq0bejHPQE4sBd10H
         L2sgE2JZcEJzrp3Fm7y5j3WpwIzfgGIfnn0XyUlvCNr0aeKoXqQnw3RZKAIofTahNhw9
         c79imTVPstpBfwXfPYRtD6o8/MnaEhxlY/Z3D3fE6e/JXALgmzD+4UZFXURDeXiAIpHz
         pujfiKH+gOIUqG0iscwXdWCMQBh8A9IAPRwCubsPWQOCgthhCnD8ABxsD0KB1gQ/3TxY
         qDF3IqiijxrpbO0627qs0n5+sVheR1yZCDWbpaESKFe7uXUI/7xrijxlWqcwShhKxrSz
         L4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2CYBMsmQbgF+TXkPvlVXR2XIGR882kaI72ZjOlmcwgM=;
        b=qgWtgV0v2HQ1EvESUaj3BkHFgtM7c5vQcl6aJP8T2pSS8ldm01CTXnXmoIL0SUpwZW
         ja9RNd1UTUb/9cGm61+lwAx0tHyZCx/QYhilBlhNtqh3CKuMYqHTMpThxcowvhnwdTfD
         9E1yP41pqtPO8zTJBaXyRmYMZF96HlSfHZikKhcCvf6ipq8tqxzQtIstBV09Z4om9+v3
         RFMOZs75Eig9nKWXcMOBzD0jDq+0+vDu+GeOmyhbcpqq+lKgYYEu2Fkr/1EltanSTl7u
         Bv9ge5VFroygIrQsbZuEgDItvY77gRH+swlzsnHbNfio2gXu+v4tXPWOo9knEsTUma9f
         Raaw==
X-Gm-Message-State: AJIora+oYj2h1hXq7wx/SfY4fxSmzvNMhG4AZV7/9gdf69huIvIs8Pdc
        NLNH2d5FkjwbntqRrvSwUkkKBU2FSUd8hA==
X-Google-Smtp-Source: AGRyM1tqkCl6hkNvHm4O7W69pclBe75W5abkpMct/a/uyGb/+VPQ8w3DHH76u7KeCW3ZyGPqGatBeQ==
X-Received: by 2002:a05:6000:1f0a:b0:21e:950d:efdd with SMTP id bv10-20020a0560001f0a00b0021e950defddmr4896269wrb.212.1658852098318;
        Tue, 26 Jul 2022 09:14:58 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c1d9400b003a3561d4f3fsm9122875wms.43.2022.07.26.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:14:57 -0700 (PDT)
Date:   Tue, 26 Jul 2022 18:14:55 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, jikos@kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 6/7] HID: uclogic: Add support for UGEE v2 mouse frames
Message-ID: <20220726161455.GA3260@elementary>
References: <20220717144333.251190-7-jose.exposito89@gmail.com>
 <202207261047.hUEFf74G-lkp@intel.com>
 <YuAMzSBcfsyGMjNy@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuAMzSBcfsyGMjNy@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 08:48:29AM -0700, Nathan Chancellor wrote:
> On Tue, Jul 26, 2022 at 10:33:25AM +0800, kernel test robot wrote:
> > Hi "José,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on 0cb1fc0988e32bda84c2b7218e0c761af1430baf]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Exp-sito/XP-PEN-Deco-Pro-S-support-for-5-20-uclogic/20220717-224559
> > base:   0cb1fc0988e32bda84c2b7218e0c761af1430baf
> > config: x86_64-buildonly-randconfig-r002-20220718 (https://download.01.org/0day-ci/archive/20220726/202207261047.hUEFf74G-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/10fcf5d5cca4657c53477c392b1fb675d72cfda3
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Jos-Exp-sito/XP-PEN-Deco-Pro-S-support-for-5-20-uclogic/20220717-224559
> >         git checkout 10fcf5d5cca4657c53477c392b1fb675d72cfda3
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ld.lld: error: call to __read_overflow marked "dontcall-error": detected read beyond size of object (1st parameter)
> 
> Unfortunately, LTO makes this warning kind of cryptic but it seems like
> the wrong template size is being used? This appears to resolve the
> warning for me.
> 
> Cheers,
> Nathan
> 
> diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
> index 2407e927d1bf..dd4b1ed6fd1e 100644
> --- a/drivers/hid/hid-uclogic-params.c
> +++ b/drivers/hid/hid-uclogic-params.c
> @@ -1205,7 +1205,7 @@ static int uclogic_params_ugee_v2_init_frame_mouse(struct uclogic_params *p)
>  
>  	rc = uclogic_params_frame_init_with_desc(&p->frame_list[1],
>  						 uclogic_rdesc_ugee_v2_frame_mouse_template_arr,
> -						 uclogic_rdesc_ugee_v2_frame_dial_template_size,
> +						 uclogic_rdesc_ugee_v2_frame_mouse_template_size,
>  						 UCLOGIC_RDESC_V1_FRAME_ID);
>  	if (rc)
>  		return rc;

Hi Nathan,

Yes, I was about to send v3 fixing it. As you mentioned, I copy-pasted
the wrong template size.

I really need to learn how to enable those warnings in my dev
environment. My toolchain didn't complain about this.
Thanks for pointing me to LTO. I didn't know about the CONFIG_LTO_*
options, I'll play a bit with them.

Thanks a lot for looking into this,
Jose
