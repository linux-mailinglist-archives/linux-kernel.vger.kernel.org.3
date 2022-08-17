Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875BF59748C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiHQQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiHQQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:47:50 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021915E57F;
        Wed, 17 Aug 2022 09:47:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 63CFE580DCD;
        Wed, 17 Aug 2022 12:47:49 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 12:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660754869; x=
        1660758469; bh=e7kbwoZBIRw10cSPvBzfrGXpN7ylcVJroUO/rkVUtcs=; b=W
        RhtvnStTDxP3KhIK4pUtcUImXsHQyU2D8ITizJByep1+YXzheOXTPrZD5groPqcP
        hbUyBjZLN8wGheXBsVY7Km3jgIiZ/M59f814yr+5lcZQM8cpzbxS3nYzZS+DosvQ
        0jE+DxWYmhj89aa2LrAR95s0dK/GPdgENKyh/Z4hbGqrlq7EMr9I5SnO1NUXm9DW
        3OQ4JkHM6vhrzVWtVKLzVf1BVNRWNDSdPv96dgNI4oiiBt7gZ8cIdEcdQzfXh20c
        8DK0ecSBSjrn/NbzPa6ZpwT1w/jw6c2wMu79Vk1xb15wjmh8apD5As4+H0Zn46Qp
        qSj8Nim3wyxUBPMIPFS9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660754869; x=1660758469; bh=e7kbwoZBIRw10cSPvBzfrGXpN7yl
        cVJroUO/rkVUtcs=; b=r5z3tV2FlA4GSpPjG6dhyeNYMQFOIm7qyWpFqy0J17x0
        ETY87suOsddfQdzhT6nlZ0GkxoGAkPtMdOlH7KUvesU7K50mPx548B2twDDdrnP5
        Q36dn9kYz+HfgsGw8f9+8XsiGSeeMuTmDFt5u61R2HxpgIN04NAgiQqv6824lM/Y
        6uv8+lcWvEdZc+LjddQrqNcnfLcu94sUyolwvB6Qxp6o5epZ6AIw+TPigBNiu7iA
        ClJdLOa8SLSqCuByZuqxgihXEeGWUDiiN5NGebZdpF5RzspsYYmJ0ECcdgmcWJYs
        1KAGL4xNGxfIvZxStGFc36vRiPUiRy7e0wYMRBSbjg==
X-ME-Sender: <xms:tBv9Yn-CFrLqh5B28m98OCtHZuFV_yo2qvQfjmGndkoPXUlJZ1OH0w>
    <xme:tBv9YjvG3cNWLLadhHnSzENLxpnFB4IvWtv3oIewqY293bsTKzVxAc7930NJgN3yV
    d85AZaRHy4mYZB6O_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:tBv9YlDBSoX93SmklgMEIdo2g6T0mpyPnO5ZroKEwrtRyPh2icaaHA>
    <xmx:tBv9YjebJcWlvHMPzmSTBI2nOmnULkpH3ipXQAy7K4XXzv908rdUJg>
    <xmx:tBv9YsNEbr-7QYUb_QHbDBkEHJennFLIb56g1AvHzpw9lsWgTYDz3g>
    <xmx:tRv9YoCFtdHumGQK03Iqq2u1MdiDPVjuVsFvFI61xpboDlC-6K2GRw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BFEF51700082; Wed, 17 Aug 2022 12:47:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
In-Reply-To: <20220817163059.kigrvdfmxfswmhls@quack3>
References: <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
Date:   Wed, 17 Aug 2022 12:47:23 -0400
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



On Wed, Aug 17, 2022, at 12:30 PM, Jan Kara wrote:

> BTW, are you sure the first problematic kernel is 5.12? 

100%

It consistently reproduces with any 5.12 series kernel, including from c03c21ba6f4e which is before rc1. It's frustrating that git bisect produces kernels that won't boot, I was more than half way through! :D And could have been done by now...

We've been running on 5.11 series kernels for a year because of this problem.


> BTW that may be an
> interesting thing to try: Can you boot with
> "megaraid_sas.host_tagset_enable = 0" kernel option and see whether the
> issue reproduces?

Yep.

-- 
Chris Murphy
