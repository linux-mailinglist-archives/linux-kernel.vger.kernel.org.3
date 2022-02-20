Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEA4BD16E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243186AbiBTU0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:26:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiBTU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:26:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926A3968C;
        Sun, 20 Feb 2022 12:26:06 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i11so15006585lfu.3;
        Sun, 20 Feb 2022 12:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G4fVxuzKrXmk38T9ip2XGji02lbnRZqnCl8NZe97wHE=;
        b=He1Y719i4nk05titS+vnyIbXkWJVbwJ8jXoEnZOmY1VD+fE29A0WSXEKhp++2F+E9G
         /cq7CQpdZCwDnwP2EGewSN8lQNBXzFPxO690+2/fVofhEr+vnFUF1GyJQJ0g7X9ggPZU
         OT50Si0Zz2DHx7fGcUCyz1mrCaRIvWhW2pWh/f2p8z7QcJ43MwjhKoUSWAR/ggN4upqK
         qtWVaiiPNmTTTZuhtD4gAdVK/lOcJxR5HerXKrMrjFEVu0SequidsDZ9+dM7nuN69/Do
         4gqn1snpubaj/fHPIh4coXn09n/MVbeVkO5tgwEbtO7+V9XAi7/KddsXnwzWomjBZ3rt
         osBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G4fVxuzKrXmk38T9ip2XGji02lbnRZqnCl8NZe97wHE=;
        b=FmuI4GsOYSt78e/3A5767rdCtmW1B7bgQ/Pg4t7dVyse0GpKUFU3n7lONuKAsDZ5l3
         BNBepZUZ3o2hRNckVJp8+78ALJGe5Tl4tB7JBrvbI9H9Lj1kxGWwG4LRpR/prQMdEslm
         9f0/bz8WeXOp9MCT7J5Pn3UYoqMB+hu/nnKf0DqJk6mEx/7xuD9HHG9OjfxkkX9OlRQJ
         s2f9kliRx+luPHDEu4WAvTVJ12L2AghzcBaXzHeMgpp+Rj+Ue7fPU56OkmFDn+ErrVaV
         Ag+SDxeBIB4GuLcGlljntZZwVFxEVBj1zG6f71ZryAHu/xcNEgjE9QhaOPLZXBpNghLy
         +Mnw==
X-Gm-Message-State: AOAM533FlZ3ICOqW9q3EBETTP/GHgJhrR6jxX0M9bo5FfvQ++RVxbivC
        vbAL37bezvOGO49uptWNYscm71pfoSg=
X-Google-Smtp-Source: ABdhPJxQVI93xxc6iHZZTjo1QbebVWjw6taqMs6g/mPjpLmKZVeMZO/UN7svWA1nLVwFm8CjugquGw==
X-Received: by 2002:a05:6512:234e:b0:443:d569:4366 with SMTP id p14-20020a056512234e00b00443d5694366mr4961370lfu.490.1645388764361;
        Sun, 20 Feb 2022 12:26:04 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id s4sm914433lfr.73.2022.02.20.12.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:26:04 -0800 (PST)
Message-ID: <65dcd557-984e-8801-96c1-0f14f4d6589b@gmail.com>
Date:   Sun, 20 Feb 2022 23:26:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 6/8] media: staging: tegra-vde: De-stage driver
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220220172950.3401-7-digetx@gmail.com>
 <202202210437.dSxqXeIm-lkp@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <202202210437.dSxqXeIm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2022 23:19, kernel test robot пишет:
> Hi Dmitry,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on media-tree/master]
> [also build test ERROR on tegra/for-next linus/master v5.17-rc4 next-20220217]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Add-V4L-stateless-video-decoder-API-support-to-NVIDIA-Tegra-driver/20220221-013333
> base:   git://linuxtv.org/media_tree.git master
> config: x86_64-randconfig-m001
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/dd010c4949a824dda7225b7074050b5736d3894a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Dmitry-Osipenko/Add-V4L-stateless-video-decoder-API-support-to-NVIDIA-Tegra-driver/20220221-013333
>         git checkout dd010c4949a824dda7225b7074050b5736d3894a
>         make W=1 ARCH=x86_64  randconfig
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 distclean
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> scripts/Makefile.clean:15: drivers/staging/media/tegra-vde/Makefile: No such file or directory

I had a feeling that something is missed in v4.
