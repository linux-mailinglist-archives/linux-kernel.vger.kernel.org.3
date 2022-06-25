Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D931955AD97
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiFYXgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiFYXgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:36:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39E313D26
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656200161;
        bh=XV2Ej1IiM47JIIlEx5yn8yUeRbuQU6JT9jLZlqkHh3g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JCr9yx3J7KJKDZ9jaSQrwjydI93pVGGsxYaOJHEMoDRW+nG5clVcqnhDfyKQMl7vh
         6Nf3BoI8OKSgucckJmIVolhVMU+Fu/Q/FiFhA1GphDh9TVHnQZN9VGEiAdM51wwstP
         l8AxiBcmA2KystUSpjuFxuL+LuP3bDkb7HUKzaRs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.162.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC34X-1nxIh208Cb-00CTSR; Sun, 26
 Jun 2022 01:36:01 +0200
Message-ID: <4b60d5c1-cc56-aebd-955e-c1d5725bb646@gmx.de>
Date:   Sun, 26 Jun 2022 01:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [linux-stable-rc:linux-5.15.y 6925/7971]
 drivers/video/console/sticore.c:1132:5: error: redefinition of
 'fb_is_primary_device'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202206250202.k6n6Wsy4-lkp@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202206250202.k6n6Wsy4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rBZRZoTf2XnPrOxlXmMOQmMDxt7dR2VeqCndsfK1C3o6/rycDCR
 ERZ/f2O7eME9bc8FLkQf7mzXtf7QqFNnHei4BdTgOgHEVZ+DMUqhAskTVLXNlRSSXpLCxsc
 GC1XerKqDBYeSlXQ3MsWQJjysEnQo069S2lDOzV9qzUTgoU4J17xZ7tcDEB0Mc52f/DX5is
 pnFpMH7hZqIJMlYf1M+8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHJdve1h4kw=:OF+oOVybvj/8/6gOE8T1kC
 yQETybJbu3QscSP1l6jjyr16D0CRXGHK8BmaZTfufvUWK273UM6mf8rETYIBQ4qwsyWCTyJDt
 cnLicn8z9zPwP1+dhEfcjvZ7fQkGhc+5+wIU7z7EoQA3rrkNzQhISEwGKStS33PL39MxtV/hN
 WFwanl8XmLfLoMsriwDjL7GWoKbq9AgoAZ0bvKaV33N3MzNdkxV0EA0JICf7zzdPIF1jpT4+l
 9OBhZxB7m7OAgxpTFWZsfvb27ndjWySFpLsN0LH15AopGhNhhGjUMj9etSHutaB8wP2sqJslQ
 Z/4uexDYm2yPFV8sZJ3PLW8eZfXeFrDhQd4P7OV2Sazaw2gf2wQOFx1z/AZdUPg+CsGA//2r+
 X3DXgWZLWb7Kme0BFeZS8Ly0/NecmO+oF/dtjrCbNaREtb8ru/G4N2nHLr8EM3WN+5zZvDFSt
 pnK6c4Lf4WzW1o2rr2ocWcLCL9nIF0egBFyDSxyeYrTxkNaB9AeHHCfpmWVYncWM83e6ny83q
 CfqKu0RZCgg1G1K2wGspo1VlQ6/hC4WDqiUHmDhXmehQz7ZfdQbVD+NLiTs96gbUd8j3ly12/
 LtM+RzfaGX7bRVgT8LR8r4/YxBcjtuIcg+BUG/8oS9ofzgX/uWs9vwQoMYBdiQqMIpSuAgNjH
 xMzwqianQYhYyj9SfgWVJ0vCZy+ZqiBjA11FYSRDB970hkHDmUj+yK0drRJL1LpOUUTr1B5Fq
 lRqinjJnpj6qB1MUoEnfsQztpplJQik5g8/N3bXpeBb15/unxS3J8x2galhUWmfGKjF8XCB4N
 gvAflc3O5ZSbTDzLWwJIEWlh5aLsyOrm4A0R7V2QRKJZ1t/O2G+9qStDij5o+zW5OBVM7NTTh
 w7hQaM6rhGU3vMPXRWDADUY3GOygrioqqSevnS7xDcpImrvSfTFK7ntqyl7RFcenz6H61pxA9
 EqgRB6KnaS+8WzBuF1AGlytdOP8i6XXXu7ITMJECUVqLkjXWX5mZKCJNtkP+PyMc/5FhqC9r2
 vhk1CIV5uoP2TVrovjCtIwskhryFXvNaGuNAJxz3dAQqjDt4kh5JMSP5zJkBcjbvPkWJ1SQ/+
 BtuIw0+ul/dSyQ7tyMZKtMfPQf9tBxuNQHocaXcS1b9AkVW4g9tuVNtzA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/22 04:58, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-sta=
ble-rc.git linux-5.15.y
> head:   add0aacf730e0bba8de6382b896a9a55b022cb59
> commit: 8b8fe78cae1d09229f544f4129b8c87ca7a8f367 [6925/7971] parisc/stif=
b: Implement fb_is_primary_device()
> config: parisc-buildonly-randconfig-r006-20220624
> compiler: hppa-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-s=
table-rc.git/commit/?id=3D8b8fe78cae1d09229f544f4129b8c87ca7a8f367
>         git remote add linux-stable-rc https://git.kernel.org/pub/scm/li=
nux/kernel/git/stable/linux-stable-rc.git
>         git fetch --no-tags linux-stable-rc linux-5.15.y
>         git checkout 8b8fe78cae1d09229f544f4129b8c87ca7a8f367
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash drivers/video/cons=
ole/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/video/console/sticore.c:1132:5: error: redefinition of 'fb_is_=
primary_device'
>     1132 | int fb_is_primary_device(struct fb_info *info)
>          |     ^~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/video/console/sticore.c:33:
>    arch/parisc/include/asm/fb.h:18:19: note: previous definition of 'fb_=
is_primary_device' with type 'int(struct fb_info *)'
>       18 | static inline int fb_is_primary_device(struct fb_info *info)
>          |                   ^~~~~~~~~~~~~~~~~~~~
>

I've queued up a fix for this in my for-next tree. It will reach v5.10+ at=
 some point...

Helge
