Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF19597B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbiHRCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiHRCcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:32:16 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1758085;
        Wed, 17 Aug 2022 19:32:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C72B15809F1;
        Wed, 17 Aug 2022 22:32:14 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 22:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660789934; x=
        1660793534; bh=Dg3lZIUBn8ktbKE2tjHQauC07j8CEBmMwKDQfaoiWGo=; b=w
        LOFrKFri4BUQ3b7AR5n36w9aw3yzWBnGKS51gkKgYdYUC5ZFD4pfU//TUgfDfKUd
        MJeG9qPO/43xOU/QDtSRscMZtopaGyxD7Ms7pEWHSur6yrEqA/3Uv/bj4SdPW7Po
        GGPcxsTD8h+enKHaR3u9D4YrqlR2Vsuxh6eSC+IWWM9QIjD6b5hlsxgm4rrp+FnK
        AZGHR2Ac7wfDlkHkHvkS3q7Y6t9zA80uqNJuUa5m0I5cjCSN5foeYIiqlXFDSgp5
        iYE8nbNsmxALWYyWIQr1+nDXvy52LRt9B3HxEzJ1J9Xf8aBvKpkCzJF2YQhs+z94
        OVnMVga4J/9wInCAyQiyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660789934; x=1660793534; bh=Dg3lZIUBn8ktbKE2tjHQauC07j8C
        EBmMwKDQfaoiWGo=; b=qvQmIIwTNsdAQNov9+uqL5k2CdiUgbUqpg1PY5v1FBRj
        8hcWJa3lswiXU/s3TBsFHH1/fHoHPMOGbeSwKo/giHqFYfvu5XBukxyJFU/+7dFP
        uBmtA+HtT0GEabsrCj/rmbIGoE7FDLKT3UIdRsniX1ag2jq9Vp6ZAiZYwdNk6EAd
        1rWHG0I3OXqLkhF+d8EP0Tkf+OXUImRrzQNhWHmgrUmCstyup0dHJPPJKNuUlMiE
        cTNaTXgcW1XRgejzJvl/6dFzUOffcC0AY5pT1NtR1JDdIFuZkCAwTnpv3z0F5W1W
        txPZikRKc2HwN2UPlFsuSHiRg/WmN3ktrEpuKsryiw==
X-ME-Sender: <xms:rqT9Yjs2bbuyTpQPYQcLX-eHKYCeWdSN7fR8jGlbP_IIAYD7kRYZ-Q>
    <xme:rqT9Ykc1k1x4xjitOuzA6U_dZu1yXIBBXlTydVfjqFjMNwJn7mg8ZS8R75a-DB4b0
    wOUlZWkLD8wHCtrWwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:rqT9YmzRX1N5uSCS9PWh1fjtlkzkpIRS5yCF943-KJV3HIrTCihxYA>
    <xmx:rqT9YiOfZpLiMoAOalTt5n5EvswMod1lQFwCD6NHkBVxaJR11hkUMw>
    <xmx:rqT9Yj_4MtNG46BO0RV1oJ1Id0FBpEA6buDS_KMqbA4i77YYuQMZXQ>
    <xmx:rqT9YjygUM_LxVTbXR-Fu9xoHaj9CnoFNDUI3otnocctc9QtYG-WIg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6AE601700082; Wed, 17 Aug 2022 22:32:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <c233d75c-c8d5-4fba-b102-925fe537aad3@www.fastmail.com>
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
Date:   Wed, 17 Aug 2022 22:31:54 -0400
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

I ran this for 7 hours and the problem didn't happen.

-- 
Chris Murphy
