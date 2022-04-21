Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20AF509A92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386634AbiDUIZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386714AbiDUIY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:24:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99DA20F71
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:21:41 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8GIa-1nusK33vTU-014C6d for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022
 10:21:39 +0200
Received: by mail-wm1-f43.google.com with SMTP id q20so2707195wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:21:39 -0700 (PDT)
X-Gm-Message-State: AOAM531nyyOsY5wyacrPelIRwg/QM9PGZzoNkyzIX2919SuEZXWL59jN
        tUsaQEb5T72nJDRZnQZ5N4f0g344F8hcg4qbvhs=
X-Google-Smtp-Source: ABdhPJy9ynKtmGb2Ar39s0Ilk4SRIRNL+imBrjFffev6/gzKGwG0reRCbxVIgiM3Ev1tqDZG2inxaIb2rWiJKcdtcaU=
X-Received: by 2002:a05:600c:25c5:b0:38f:f0b9:4c8c with SMTP id
 5-20020a05600c25c500b0038ff0b94c8cmr7708512wml.20.1650529299557; Thu, 21 Apr
 2022 01:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <202204211543.9kdHTsCb-lkp@intel.com>
In-Reply-To: <202204211543.9kdHTsCb-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Apr 2022 10:21:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0yyMPmsxOCZjooSZ7W+Obs_LXBangE_h8M-p4MgcsP8g@mail.gmail.com>
Message-ID: <CAK8P3a0yyMPmsxOCZjooSZ7W+Obs_LXBangE_h8M-p4MgcsP8g@mail.gmail.com>
Subject: Re: [stable:linux-5.10.y 644/5321] drivers/staging/comedi/drivers/comedi_isadma.c:25:17:
 error: implicit declaration of function 'claim_dma_lock'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ld82pWttJQHsAuj27I6yeBBGEhrMCsq3zY3rF9WPPc4+gAfvWC4
 hD1V/SEBgQEaoLJYCZNTynqVx5gOKFMX0eZ2q4baGApg16xsoUyNIdi6OU4kNTBkwb838ca
 5GuImn5035AQBx6VAjY10O25lTRmtAxiaZplSOmAPKBpxhQ/ovctLy3uWkLlkGR7FtToib2
 /thVndIV04vlkjSWd56OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s17Y1i4Whv4=:AmNmreXj/R7uvLaCSXTob+
 GTbpgPbybeTSr0HupLKeXHKqc9QQ/miam76JShh5zSnDReQnN96AceqdRQlLG1ee7WSrUVoFV
 mKqwxnKBFbCZ6iRQUvwq3bVUZ6Sc3Fnf9KRTxTbr76pNfRDrljno2bEtQv3jYXySHNVr+igWe
 1zPHZKOsvWTFRs+juAzIS4eKeM3X8y5RWkwqnIv2ezK2X5RufQRd7Xua0O7xFoJTFCrwBC3fl
 /dvIL2n7/olCTwZ7CoadY2PWToO0RMc8VQcO6cOkAgaruaviJzMi6LFNmWG7xqOUYxNFxWp8w
 lXfR2wg3CFuKG3BeHcDwDuGd46Jd3PLBQh9leZNV6wkyNdlG13ryuHWYXL2QclD8d6WvgHz4w
 Hg3+xm92hg0z1oLnblVxVYBJhVU3SSbEyVic9M9XI0L2+/oTR57sFDGqDmIWeJyyEgA42Sbp4
 8pZ6DyhyYPV+1DYQgNwhEMqfZTYS9+WtRLXZZ8mDcoul+KlE1JAdKpQ8eJrSwH/Wn0YSor4TP
 h4EqLmidRbk1PvbpbGCYJJzvr7d5/75dOfKRIRmU5iPv8fSqyql9FG4J7I3A9/EVJZBGl3FVo
 wgXb7qzThyfIPnLwx1eoxtB1BodmVeeIPMejrAg4NPVvS3j0G3d7nyyEN+nzBGaEeteTs/5qJ
 A+crgUPMh2SlTehxY4PBM+i1hw7BlNz1PTyMbUxp2Wv0AGgDT11VvMShQzzY/qJoxONFqcseD
 D7JSsFYTC12P3xAQ8+KlZal9X1B6Ue6bFZzd9Nj5oARaFlbiTX1h5hbBcoE3Hyw3JqOwtNrpi
 h0Z893npmxTdOLQCzeUv9GHjivC89o7aAN3N6RWT9Hyw+gzP9o=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:09 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
> head:   1052f9bce62982023737a95b7ff1ad26a5149af6
> commit: 87ae522e467e17a13b796e2cb595f9c3943e4d5e [644/5321] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch

I sent v4 of my ISA_DMA_API removal patch for coldfire now, that
should address it.

     Arnd
