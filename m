Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AFA510F18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357343AbiD0DEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357339AbiD0DEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:04:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6289635A85;
        Tue, 26 Apr 2022 20:01:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e24so325869pjt.2;
        Tue, 26 Apr 2022 20:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YFRxO/r5+25A3ri2yhfDFSr+8xdRCcRJYthCA85JqcQ=;
        b=K1Q2UxF/3GoOvh7IcM7PMhrYYxuk/fttGjz5MOklYiQT+XKXcUyvBefte56ClIFBvB
         74qaaxun4xBECJrwYtU+rpfozcIaiW7K3sm0s/3rcmqItySScz4mV/dK8Z1dbfIQJK03
         6qB7v2jvah5TcSa/70kLVzHACv4IoabG3Pt2rRJikhLkym9iSGtba5v5TmhadOTHQuXH
         d/1Fk3XEWrMsAw+l6Yofn3wrWdc/JeIUtw77a7woKYJ3+PS75DxlaHlerviDpHEbfA1S
         VkxSoKe2bls6tV8OumP9a+Wh2Icp3Xp0olQ+531BAGdifF+IyLmuqU9tq3cA3fh/EWJj
         ybMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YFRxO/r5+25A3ri2yhfDFSr+8xdRCcRJYthCA85JqcQ=;
        b=5l4SZiTPkU2u22+mM9uyHfDrCCWR9i69OoiLypgnrQIdhoOFpISYHTys2UtcUT6oiF
         2jePV4ZmA++IogHYhgaF51rYWDuf5lVYwZ5r7tJFyvgyo3uqyO6Xu5fW4Jv5z4sdnkbn
         DX8NEP/Czlx5eRNSOHPxgZt3J2meO/rLYOboBE/R+MytrugbEtfCHF/fJ/hw2AFBCDt0
         vKe9Qwl+FmL0bkpjB0sA6MzkWuAeG9rY3WJED9c8uyR+Slqx0b4Z2tAAUGsXmlNutGlo
         P1IMUrDNzjJVFi9fqNTWF9fzmNdzWWJcz+95YqpKnMAnwGCJ3HyeyoSn5WYS8TtsWRrd
         IHiQ==
X-Gm-Message-State: AOAM532E4MSLu30LmcUdgD/ahIjWLseky5Rj2d4n4vBSeKof5XqfAEQ5
        h+ekGiAde+leDdDnIzbWXZA=
X-Google-Smtp-Source: ABdhPJxlGRM2PNdLt5aZbnAxAcHXkd1gDOPqO85JodxC+Oj77+ihJFifLCy5Xm3v7BWxQNWbMW8N6A==
X-Received: by 2002:a17:902:8547:b0:15c:f02f:cd0b with SMTP id d7-20020a170902854700b0015cf02fcd0bmr18672461plo.117.1651028485671;
        Tue, 26 Apr 2022 20:01:25 -0700 (PDT)
Received: from jagath-PC ([27.7.30.122])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm18438245pfc.111.2022.04.26.20.01.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Apr 2022 20:01:25 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:31:21 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, dan@dlrobertson.com,
        andy.shevchenko@gmail.com, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] iio: accel: bma400: Add support for activity and
 inactivity events
Message-ID: <20220427030119.GA31584@jagath-PC>
References: <20220420211105.14654-10-jagathjog1996@gmail.com>
 <202204211211.febbJ6fy-lkp@intel.com>
 <20220424172002.7dd48dfa@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220424172002.7dd48dfa@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sun, Apr 24, 2022 at 05:20:02PM +0100, Jonathan Cameron wrote:
> On Thu, 21 Apr 2022 14:45:05 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Jagath,
> > 
> > Thank you for the patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on jic23-iio/togreg]
> > [also build test WARNING on linus/master v5.18-rc3 next-20220420]
> > [cannot apply to linux/master]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220421-051244
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> > config: mips-randconfig-r031-20220420 (https://download.01.org/0day-ci/archive/20220421/202204211211.febbJ6fy-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install mips cross compiling tool for clang build
> >         # apt-get install binutils-mips-linux-gnu
> >         # https://github.com/intel-lab-lkp/linux/commit/b33d9910aa7588ec8db7c1694dbc03c3ed200ebb
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Jagath-Jog-J/iio-accel-bma400-Add-buffer-step-and-activity-inactivity/20220421-051244
> >         git checkout b33d9910aa7588ec8db7c1694dbc03c3ed200ebb
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/iio/accel/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/iio/accel/bma400_core.c:1047:17: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((msk), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (msk)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]  
> >                    field_value = FIELD_PREP(msk, state);
> >                                  ^~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
> >                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
> >                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
> >                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> >                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> >    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
> >    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                        ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> >    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
> >            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
> >            __compiletime_assert(condition, msg, prefix, suffix)
> >            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
> >                    if (!(condition))                                       \
> >                          ^~~~~~~~~
> >    drivers/iio/accel/bma400_core.c:1053:17: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((msk), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (msk)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
> >                    field_value = FIELD_PREP(msk, state);
> >                                  ^~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
> >                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
> >                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
> >                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> >                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> >    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
> >    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                        ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> >    include/linux/compiler_types.h:352:22: note: expanded from macro 'compiletime_assert'
> >            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:340:23: note: expanded from macro '_compiletime_assert'
> >            __compiletime_assert(condition, msg, prefix, suffix)
> >            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:332:9: note: expanded from macro '__compiletime_assert'
> >                    if (!(condition))                                       \
> >                          ^~~~~~~~~
> >    2 warnings generated.
> > 
> > 
> > vim +1047 drivers/iio/accel/bma400_core.c
> > 
> >   1035	
> >   1036	static int bma400_activity_event_en(struct bma400_data *data,
> >   1037					    enum iio_event_direction dir,
> >   1038					    int state)
> >   1039	{
> >   1040		int ret, reg, msk, value, field_value;
> >   1041	
> >   1042		switch (dir) {
> >   1043		case IIO_EV_DIR_RISING:
> >   1044			reg = BMA400_GEN1INT_CONFIG0;
> >   1045			msk = BMA400_INT_GEN1_MSK;
> >   1046			value = 2;
> > > 1047			field_value = FIELD_PREP(msk, state);
> 
> Ah.  Will need to clamp state to 0/1
> 
> 				field_value = FIELD_PREP(msk, state ? 1 : 0);
> perhaps?

For this also compiler shows warning.

To compile for mips I used
COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir
ARCH=mips SHELL=/bin/bash drivers/iio/accel/

../drivers/iio/accel/bma400_core.c:1047:17: warning: result of comparison of
constant 18446744073709551615 with expression of type 'typeof (_Generic((msk)...

                field_value = FIELD_PREP(msk, state ? 1 : 0);
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \



To avoid warning can I do like this
field_value = FIELD_PREP(BMA400_INT_GEN1_MSK, state);

>   
> >   1048			break;
> >   1049		case IIO_EV_DIR_FALLING:
> >   1050			reg = BMA400_GEN2INT_CONFIG0;
> >   1051			msk = BMA400_INT_GEN2_MSK;
> >   1052			value = 0;
> >   1053			field_value = FIELD_PREP(msk, state);
> >   1054			break;
> >   1055		default:
> >   1056			return -EINVAL;
> >   1057		}
> >   1058	
> >   1059		/* Enabling all axis for interrupt evaluation */
> >   1060		ret = regmap_write(data->regmap, reg, 0xF8);
> >   1061		if (ret)
> >   1062			return ret;
> >   1063	
> >   1064		/* OR combination of all axis for interrupt evaluation */
> >   1065		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
> >   1066		if (ret)
> >   1067			return ret;
> >   1068	
> >   1069		/* Initial value to avoid interrupts while enabling*/
> >   1070		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
> >   1071		if (ret)
> >   1072			return ret;
> >   1073	
> >   1074		/* Initial duration value to avoid interrupts while enabling*/
> >   1075		ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
> >   1076		if (ret)
> >   1077			return ret;
> >   1078	
> >   1079		ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
> >   1080					 field_value);
> >   1081		if (ret)
> >   1082			return ret;
> >   1083	
> >   1084		ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
> >   1085					 field_value);
> >   1086		if (ret)
> >   1087			return ret;
> >   1088	
> >   1089		set_mask_bits(&data->generic_event_en, msk, field_value);
> >   1090		return 0;
> >   1091	}
> >   1092	
> > 
> 


Thank you,
Jagath
