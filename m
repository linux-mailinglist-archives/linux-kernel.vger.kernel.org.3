Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7C9597665
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiHQTYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiHQTYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:24:09 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D985E67165;
        Wed, 17 Aug 2022 12:24:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5BD3C580BD8;
        Wed, 17 Aug 2022 15:24:05 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 15:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660764245; x=
        1660767845; bh=i6g6uhetDZvPnuAOa38J5AKruYl3djzKfCW4PCzxY6Y=; b=Y
        NMS7yyfXPFMaiZGsLL7J3h+e4rw2M/AeNtS8dkIywnXgNqTHQu5xRG5nkGm84URL
        lpNfik3egDOJtp8iV0kCphYKQALNxGrE8ZexhhOQeJsNT3KO2jMRe2Vic6aF6qYb
        6cFNhCdp+JH1npjrGznwbpnSHVukUMPb8ebbl3NN+3x1ThpwhYXAdx/KP7xY06XS
        zGwL6XG5/lyGR4lr4Emq1mcFBVndlP0XNV+R/2MzzKlZBQglgh+2gDXOoZ/5nR2f
        ZzzmXVzZebYJPgLY7hHrekeJ2AOvtaYlAYKNGOAQyhW4SWJRR/4zJM+nle12oZbw
        zU7+ifK/17689dig4LW0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660764245; x=1660767845; bh=i6g6uhetDZvPnuAOa38J5AKruYl3
        djzKfCW4PCzxY6Y=; b=pPruFcAjUVUuJy+I8ncL+yUzveYopoo3pSDrlEVGsb95
        oXmAEv9Mn3dbL+lNGsxLpZw4H0X1MgguURVqcNh/U+czvwUax1dFPI3Qr/VKwTCT
        VG3t8AOAAArtdFSr3auwaJMRriUJHyjo15wpZWfst0H2+QjWr4FEd3CsRzduhAIJ
        Y0ApjcmfesJ5/BPOlE9S5Pf+WGf5L3KEt3DJ+14yV0GWMXPEstA8tFf3b6p1c/75
        dwwXEFh7MNVokCu8vrRNe/wsyQS32pIBuS1FK90RbsspjBOJ/U/iSaB7vQnrFSF1
        9KOIU4p5PAFJUWpyVvCZWzonDYs/gkPHiEpnN9udFA==
X-ME-Sender: <xms:VED9YmOKQW99bNRyG-lc3nGSWs_h-ihVLmMXtawcWSqzrWzMACwbPA>
    <xme:VED9Yk_6dvZPkwJDIimMhKUPr_if7IPUQkLP0T4W4JcQlrdVVF88BTDSywysOPPcZ
    Fpr3oYiMj46BAuucLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:VED9YtTlvw8ztfgobE4F41Ky7_PKq9lZ9W_ma1Y154LaZA3Fbv71AQ>
    <xmx:VED9Ymu_hBnOugzNB4o-bHa9qPtL3ndu5CowZs9xwBPkBUuOuQbNbA>
    <xmx:VED9YudmZ54A77Frk1aKnJOdDXZI4RBPAdCr3xmWNGAFIfxhLiz1jg>
    <xmx:VUD9YmROAkOe8hZXTh7xeHDm9VXAnNKjwjzLUliL6PosQQno83CUCg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9148E1700082; Wed, 17 Aug 2022 15:24:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <e8317df3-7955-4109-981c-f85f0416ce0f@www.fastmail.com>
In-Reply-To: <2f252399-0e30-4465-8c02-3f42c145174a@www.fastmail.com>
References: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
 <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
 <20220817181554.znqljc6mmci45ukd@quack3>
 <e4c260da-2df7-49a3-a8dc-1d3fc7ca12a0@www.fastmail.com>
 <20220817183335.47a4ao26wjopavo2@quack3>
 <2f252399-0e30-4465-8c02-3f42c145174a@www.fastmail.com>
Date:   Wed, 17 Aug 2022 15:23:43 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jan Kara" <jack@suse.cz>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 17, 2022, at 2:54 PM, Chris Murphy wrote:
> On Wed, Aug 17, 2022, at 2:33 PM, Jan Kara wrote:
>> On Wed 17-08-22 14:18:01, Chris Murphy wrote:
>>> 
>>> 
>>> On Wed, Aug 17, 2022, at 2:15 PM, Jan Kara wrote:
>>> 
>>> > OK, if this indeed passes then b6e68ee82585 ("blk-mq: Improve performance
>>> > of non-mq IO schedulers with multiple HW queues") might be what's causing
>>> > issues (although I don't know how yet...).
>>> 
>>> I can revert it from 5.12.0 and try. Let me know which next test is preferred :)
>>
>> Let's try to revert this first so that we have it narrowed down what
>> started causing the issues. 
>
> OK I've reverted b6e68ee82585, and removing 
> megaraid_sas.host_tagset_enable=0, and will restart the workload...
>
> Usually it's within 10 minutes but the newer the kernel it seems the 
> longer it takes, or the more things I have to throw at it. The problem 
> doesn't reproduce at all with 5.19 series unless I also run a separate 
> dnf install, and that only triggers maybe 1 in 3 times.

What I'm seeing is similar to 5.18 and occasionally 5.19...

top reports high %wa, above 30% sometimes above 60%, and increasing load (48 cpus so load 48 is OK, but this is triple digits which never happens on 5.11 series kernels).

IO pressure is 10x higher than with mq-deadline (or bfq on 5.11 series kernel) 40-50% right now

iotop usually craters to 0 by now, but it's near normal.

So I think b6e68ee82585 is s contributing factor. But isn't the only factor. I'm going to let this keep running and see if it matures into the more typical failure pattern.



-- 
Chris Murphy
