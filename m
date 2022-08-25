Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FEA5A0C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbiHYJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiHYJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:16:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC848EAB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:16:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bj12so21249881ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=niRs2YtuH5B5oh1E7598uKEG/vRd1+c2zDxWBz4UkwE=;
        b=dlDNTnyiWbdKLsF4H0dN4LY83Z/ZJu5EphQ9OD+H5nha4HI+2ztnNtu3H4xzQCNcgh
         mNOG4qp514QMKCj/2ZO7UAKiKzABdTw5jAnwvMaDzaqv7JJv92BbGkXzEVoh39HbmJE0
         1yjCUQ7AnC9XKs1wroKmwh9iUqxnoyakyZlzFGhkzL17nRijZS9BUt1B7ZwoR/zcOFd5
         4bc6llE7Ehv/dkHf3loIQpdly3vqPc4bsQ3GtRfOyrofV5gjVKG956ErpCUleATYmyWS
         GCrSWcjKCTmSe8sDxO+Si6qz9rTxjI72lzU8/fUbVFZhyBwiiV0CGjQ5PUHXgQSSrIfF
         UFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=niRs2YtuH5B5oh1E7598uKEG/vRd1+c2zDxWBz4UkwE=;
        b=u9yAZ3gTunUaAkbEeGKhGCUOM+TtTpRP8KmnFArm3K2Qe7xc86Gl40e6Y0ofFyTZBN
         Eh4gdN/mqw0cFGMKTdCcoEvH+GNqHv5LiapOLwM5GiOvpjJuAcTT1tpX48e7q1WNQ/mu
         OM8dLqt+qbTB51cad6bLP8jYLBqyPWjWJ2pWt9wr77qoH9tyLUUB7hXkEAjQSklugHaI
         Nm3Ln/vydVk9sFXPnmDGt3Zm2P56FCCEj7mV6WUzC2o1MSXw1m2TaHX0P6S9AD9153S1
         d6ZQMxXoTOQCrSmTe4p8cewshBsjUhGTLYEe5x6emgK1pJe65UcKVimKP6h8HIcig8s3
         biUw==
X-Gm-Message-State: ACgBeo0houItki0LW92NZ2ul2ZUhWH5FeK/w+dvOg4JLa8CsMDUhFMSN
        RUufN0OjJNvwaxeBoZkxgBY=
X-Google-Smtp-Source: AA6agR4Umk4Ifs5d6wA4D+kyy9D/qgTCDDz9Wyl+uxvXmVoIjer/V+FotX39VNEdpIVpZqLufgERMg==
X-Received: by 2002:a17:906:5a50:b0:73d:ad57:e02e with SMTP id my16-20020a1709065a5000b0073dad57e02emr1789735ejc.431.1661418966961;
        Thu, 25 Aug 2022 02:16:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2eef? ([2620:10d:c092:600::2:bb7b])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0072af4af2f46sm2180299eju.74.2022.08.25.02.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 02:16:06 -0700 (PDT)
Message-ID: <ea498e38-d1b0-1011-834d-8574cd0d113b@gmail.com>
Date:   Thu, 25 Aug 2022 10:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [axboe-block:io_uring-6.0 14/14] io_uring/net.c:1053:36: warning:
 variable 'addr' is uninitialized when used here
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <202208250535.oP4RWEEL-lkp@intel.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <202208250535.oP4RWEEL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 22:41, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git io_uring-6.0
> head:   0596fa5ef9aff29219021fa6f0117b604ff83d09
> commit: 0596fa5ef9aff29219021fa6f0117b604ff83d09 [14/14] io_uring/net: save address for sendzc async execution
> config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220825/202208250535.oP4RWEEL-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=0596fa5ef9aff29219021fa6f0117b604ff83d09
>          git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>          git fetch --no-tags axboe-block io_uring-6.0
>          git checkout 0596fa5ef9aff29219021fa6f0117b604ff83d09
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

Yeah, that part is trashy, I'll fix it up, thanks


-- 
Pavel Begunkov
