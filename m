Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7D5ABF28
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiICNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiICNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 09:47:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F4253014;
        Sat,  3 Sep 2022 06:47:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 013E55C0107;
        Sat,  3 Sep 2022 09:47:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 03 Sep 2022 09:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662212837; x=
        1662299237; bh=uqDIkoyxcAMiLmXCE3T3UrD+uLp05BUSMisS7iDN1Kw=; b=O
        gRFQnaRZg/o6hYZlLv4MYMlwQ49w1vK3/ype0108eXWyHfY2queZv5XsedkO0pf6
        9x0ktvjmVe1Qxxr+PTw4DTsUZ+1W+wzYM/nYtgg9RzBjrnQYzefj52pXNgDrkFcV
        T4By6z+hGcl5YtW9VYotyYSj2p1SdsHXR8+jnlb0zLj3jWE6e5llgb3Muvr1VXB5
        FzpKuPJeOidKurbGb4tQrg+gKNWiN1+mjerZ7RDPc2fbjdR1CIctg9ne1b9cSdDh
        HHNOcx/gIU1gyZd+n08NRpRTYQX2f6/2Wn9PLEa6eZvobP+l7IatubeeVK5TrFa7
        eKdtZrmACwe7Hnbm5y+gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662212837; x=
        1662299237; bh=uqDIkoyxcAMiLmXCE3T3UrD+uLp05BUSMisS7iDN1Kw=; b=p
        wSgTwVIvhQW6a4auSR1rqi3UsKAn5Bbo6f8gOOgsxkXmOmYnzlfwKM7L4dHftGWh
        eZOP/vrBUNcE/GsIDlwiVa7sQR/UgMbEVMJUckyN1X4gkHhnEirCX82p6wLIwaFA
        t0EVseORcxC3gRKqGFYbtSI8OW0f7NbniCt+Rs9nQg++Jh/v1kA6ARRoz20e+Kh4
        pyg+5aeAmNTPzikfqeumrBDUVgDe9I/TeIpfr5Uk5yzhNchjNGb0wt49kO5hq9H2
        gCplq7fKI/nseI/bPoL7W6ZxnLDqCYgnZ1M7hY2Q8tUVtjOGzydes3kmxP0Xs7LW
        r18CGMfz/5k8BBo6vusqA==
X-ME-Sender: <xms:5VoTY9e1AGDg3BTPDv8uf-R-7RxYm-RnUOkplh6YDnP0NflUPHxFXQ>
    <xme:5VoTY7Oy1t9Svr_qW8JJOfsHcYejrWC8KscPmE73UHIuu420fdii9100ocI9i4duL
    trZ4LsK64lTbsyx-Ug>
X-ME-Received: <xmr:5VoTY2hAWyGlARHEN6MuKN_jiQ6bsKrjEVC0uxB-ao1zVBFxhDSOWmtkk4dqvBmRTFgV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffuhhs
    thihucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeguedtgfffvedvieegtddvtefgvdevgfduvdeuveduveeifeegjefgjeff
    veekueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdguvghsihhgnhdrmhgupdhrvg
    guhhgrthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpeguuhhsthihseguuhhsthihmhgrsggvrdgtohhm
X-ME-Proxy: <xmx:5VoTY29IewREcGRfLOxnwYTPMcptPqG45vvDc_8Twnjky7b0MRKWEA>
    <xmx:5VoTY5tVKfBd-l5wmX2-hXPhnyTMhpI8lubOvFqkfzd0-k4uujJdLQ>
    <xmx:5VoTY1FRTTr9LsPdRrNYzUI_xc2pBbiEp2Fyx20UhUSnwp52Z5qHzw>
    <xmx:5VoTYzJDjjX7XzViucQKBM1P7EAKg476WMAtmXNXcbRJNpMeDyb80g>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 09:47:17 -0400 (EDT)
Message-ID: <c09fe083-e94f-17ad-43a5-4f7748fab751@dustymabe.com>
Date:   Sat, 3 Sep 2022 09:47:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        linux-raid@vger.kernel.org
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590>
From:   Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <YxBZ4BBjxvAkvI2A@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 03:06, Ming Lei wrote:
> Hi Dusty,

Hi Ming,

> 
> On Fri, Aug 26, 2022 at 12:15:22PM -0400, Dusty Mabe wrote:
>> Hey All,
>>
>> I think I've found a regression introduced by:
>>
>> a09b314 o block: freeze the queue earlier in del_gendisk
>>
>> In Fedora CoreOS we have tests that set up RAID1 on the /boot/ and /root/ partitions
>> and then subsequently removes one of the disks to simulate a failure. Sometime recently
> 
> Do you have test case which doesn't need raid1 over /boot or /root? such
> as by create raid1 over two disks, then mount & remove one of device, ...
> 
> It isn't easy to setup/observe such test case and observe what is wrong.

I don't have such a test case. For Fedora CoreOS we have a very
specific partition layout [1] so it's not easy to change that
and continue to run our test framework.

That being said there are plenty of people in the bug report [2]
that are reporint seeing this as well, so they might have other
test cases they can share.

[1] https://github.com/coreos/fedora-coreos-tracker/blob/main/Design.md#disk-layout
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2121791

> 
>> this test started timing out occasionally. Looking a bit closer it appears instances are
>> getting stuck during reboot with a bunch of looping messages:
>>
>> ```
>> [   17.978854] block device autoloading is deprecated and will be removed.
>> [   17.982555] block device autoloading is deprecated and will be removed.
>> [   17.985537] block device autoloading is deprecated and will be removed.
>> [   17.987546] block device autoloading is deprecated and will be removed.
>> [   17.989540] block device autoloading is deprecated and will be removed.
>> [   17.991547] block device autoloading is deprecated and will be removed.
>> [   17.993555] block device autoloading is deprecated and will be removed.
>> [   17.995539] block device autoloading is deprecated and will be removed.
>> [   17.997577] block device autoloading is deprecated and will be removed.
>> [   17.999544] block device autoloading is deprecated and will be removed.
>> [   22.979465] blkdev_get_no_open: 1666 callbacks suppressed
>> ...
>> ...
>> ...
>> [  618.221270] blkdev_get_no_open: 1664 callbacks suppressed
>> [  618.221273] block device autoloading is deprecated and will be removed.
>> [  618.224274] block device autoloading is deprecated and will be removed.
>> [  618.227267] block device autoloading is deprecated and will be removed.
>> [  618.229274] block device autoloading is deprecated and will be removed.
>> [  618.231277] block device autoloading is deprecated and will be removed.
>> [  618.233277] block device autoloading is deprecated and will be removed.
>> [  618.235282] block device autoloading is deprecated and will be removed.
>> [  618.237370] block device autoloading is deprecated and will be removed.
>> [  618.239356] block device autoloading is deprecated and will be removed.
>> [  618.241290] block device autoloading is deprecated and will be removed.
>> ```
>>
>> Using the Fedora kernels I narrowed it down to being introduced between 
>> `kernel-5.19.0-0.rc3.27.fc37` (good) and `kernel-5.19.0-0.rc4.33.fc37` (bad).
>>
>> I then did a bisect and found:
>>
>> ```
>> $ git bisect bad
>> a09b314005f3a0956ebf56e01b3b80339df577cc is the first bad commit
>> commit a09b314005f3a0956ebf56e01b3b80339df577cc
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Tue Jun 14 09:48:27 2022 +0200
>>
>>     block: freeze the queue earlier in del_gendisk
> 
> It is a bit hard to associate the above commit with reported issue.

Indeed, though I think now there is enough emperical evidence that
points directly at this commit. It may ultimately end up as not the
root cause, but it's definitely related.

Dusty
