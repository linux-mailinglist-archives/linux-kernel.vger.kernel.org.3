Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C110351212B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiD0SnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiD0Smj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:42:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D44DFD69;
        Wed, 27 Apr 2022 11:24:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B6BB828C1;
        Wed, 27 Apr 2022 18:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D194C385A7;
        Wed, 27 Apr 2022 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651083852;
        bh=MHOjsKIOkpl16ebEdUT862xHxIQgQNSBZr99E2fUavA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TGlNsS/Z6o3YV+926hptUWTKnsTRp7heWZ5Sx4cB7Ed8xGLlg+DJgQB4emoRTe09z
         qDlLLw6riouzegkNRLdcVdiagWJIaRw1/hRj1J+wba3EDSV1v3ViVHQG8b99DEj60k
         6mXDE95qsqqFXeDBIijymkuD4gYLLeFcmFVI0uJeXBh20wbah/LZkUD9YpmtmY/oW+
         /G7B5QmVHBAMdYtE/6MjWdPbubW9GQ4KpCHW68b9QfCsCQjOuVbuEISqtlg8rzemsS
         bVDtmIv9lhUD1KJX/Zgk6o/PftEQC6xMoioEsYujvhUN67it62vEfo/dW869BE+0ye
         DMvK1OHckWI8A==
Message-ID: <fe81598e-e2de-5923-248c-5fb3ad7e70bb@kernel.org>
Date:   Wed, 27 Apr 2022 20:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/5] add xhci-exynos driver
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <CGME20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a@epcas2p2.samsung.com>
 <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <3ce5f3b8-3c6b-1e83-94c2-84f4ad8aa9dc@kernel.org>
 <20220427094942.GE145620@ubuntu>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220427094942.GE145620@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 11:49, Jung Daehwan wrote:
>> 1. What is this based on? Output of: git describe
> 
> url = https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> fetch = +refs/heads/*:refs/remotes/origin/*
> 
> or
> 
> url = https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> fetch = +refs/heads/*:refs/remotes/origin/*

Thanks, although it is not what I asked for. It's not the output of `git
describe`. To get the output of git describe, execute commands in the
shell in the Git repository on your branch with these commits:
  $ git describe

>> 2. What does the scripts/get_maintainers.pl print when you run on this
>> patchset?
> 
> I don't see your name in xhci even for whole usb/host directory.
> I see same result on above 2 gits.
> 
> jdh@PlatFormDev3:~/works/mainline/linux-next$ ./scripts/get_maintainer.pl drivers/usb/host/

That's not the proper way to get list of people to Cc when submitting
patches because it does not include the contents of the directory and
contents of other parts of the kernel which you might change.

> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM,commit_signer:170/184=92%)
> Mathias Nyman <mathias.nyman@linux.intel.com> (commit_signer:52/184=28%,authored:25/184=14%)
> Alan Stern <stern@rowland.harvard.edu> (commit_signer:30/184=16%)
> Chunfeng Yun <chunfeng.yun@mediatek.com> (commit_signer:23/184=12%,authored:21/184=11%)
> linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)

So either you run it in wrong way (not on the patchset but on some parts
of tree) or you still have it based on some different tree.

I just applied your patchset on linux-next and as expected output is
entirely different:

$ git format-patch -5
$ scripts/get_maintainer.pl 0*
(... skipping entries which you pasted)
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
(maintainer:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM
ARCHITECTURES,authored:1/7=14%,added_lines:4/25=16%,removed_lines:2/13=15%)

linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
S5P AND EXYNOS ARM ARCHITECTURES)

linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
EXYNOS ARM ARCHITECTURES)



> In fact, I manually tried adding you as you commendted previous patchset.
> But, It seems you changed email id and domain..

Up to date email is printed by scripts/get_maintainers.pl. If you don't
use that tool but add addresses manually - might work, might not.

Anyway, it's not only about my email - you did not Cc relevant mailing
lists, which I mentioned weeks ago as well.

Best regards,
Krzysztof
