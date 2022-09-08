Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166F5B1E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiIHNQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiIHNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C6BC0E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CB85B82073
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF2BC433D6;
        Thu,  8 Sep 2022 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662642979;
        bh=1MwV8RWI0jf3epFZ4UP5pNpxsGscp0wqmaQjUfjn1/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nTSVKDFg3heO0PqzgeFWFfXS9szNhLrmlvLNRiw4IayygvT8A1jED1FaUo/iSX8Uc
         kkMfhwgvhleXTCU/vZ/dncupXrG3vNXfhGxHHxkLsrKePBfKts8Eu2GmrA+D+95H++
         bhabcKvZmcsIlZw0k8yVXjQa7MeFy1m4Q/BFyLP7+YnUxwxHlGzzogEN3+I1DeMpKl
         tucu2j8JdxLHvWXY+uw8EX298Mo7iRHXgTAfRWoVO2g9zSD/cRShnkaDXHtSP7mUQa
         5AXm+XZn+vUAMP1VQJlBNQuPcLj6rUDmZyXB2eZOUw4DA2yXo3jez2sHpD1b06ZN4K
         krlPOmspadogw==
Message-ID: <78da0d21-cec2-6fd7-18f7-78989cfb4693@kernel.org>
Date:   Thu, 8 Sep 2022 15:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [broonie-ci:files2POTT 66/93] undefined reference to
 `slim_stream_prepare'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202209082046.AZVfl0da-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <202209082046.AZVfl0da-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 15:03, kernel test robot wrote:
> Hi Krzysztof,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git files2POTT
> head:   e9e7df88996d64544178f48b0299dfe736c6aa22
> commit: 5b7f4e5de61ba8c44317718936864da29eeba62a [66/93] ASoC: codecs: allow compile testing without MFD drivers
> config: microblaze-buildonly-randconfig-r004-20220907 (https://download.01.org/0day-ci/archive/20220908/202209082046.AZVfl0da-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=5b7f4e5de61ba8c44317718936864da29eeba62a
>         git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
>         git fetch --no-tags broonie-ci files2POTT
>         git checkout 5b7f4e5de61ba8c44317718936864da29eeba62a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Note: the broonie-ci/files2POTT HEAD e9e7df88996d64544178f48b0299dfe736c6aa22 builds fine.
>       It only hurts bisectability.

Yep, fixed with a follow up commit.

Best regards,
Krzysztof
