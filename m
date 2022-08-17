Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1F59758D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiHQSQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiHQSQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:16:54 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4FA8E0D5;
        Wed, 17 Aug 2022 11:16:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C09A580FB4;
        Wed, 17 Aug 2022 14:16:53 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 14:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660760213; x=1660763813; bh=LPoT1cYIRF
        qKH4BtftzePUuv8BvWRYPLsFtsoIXN6qg=; b=daBKs4FZ4i4lPSX5oO6E3Otzf9
        h+U36TK2G1SqMpGFyz1v/w1fHI34nwFBwDOfYc5IaIIn/JJRPmve055xoYbIkWwO
        7Sdw5Sj5+DCkGfRMlJUACrb7+7QKL3dI+hj4K4vVwpXFpUBuMSDTUy9Xd8SfKiCZ
        6FIl/JNHGAtHc3sFY05wwAfVGwg7METfjdsKzVXt4iLAA6uU7aQ1YB6g7gnAl8gn
        2Iw5k7uX6yVDXqFX0m+gYlVxxEdp1kloIkwdcjbbk2NURNZfXwtqkO5UzVCccmRb
        7LnvQM81Mj/TfE4msOWQYaINHEM/UExQWAuno8/uFN1TCm0aHCG5pornqbbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660760213; x=
        1660763813; bh=LPoT1cYIRFqKH4BtftzePUuv8BvWRYPLsFtsoIXN6qg=; b=v
        UFbCr2BsxbwUNUUj+LpSz2nNz+fKrRywoCAE8cjr4Oc/uc77K8G0Dkf7uG1xhiPM
        CYsWjPVP1ltanN+JknYtfM9IhmJmDrSZC2g7u1Bzz9AgtLoWauTg3DR3x5HoAkQm
        gWndKdy1tvg67qjMcdw3WZ9eQP4Erx30XA5XSP5YBO4AlMzg6zQZEhQFxiFCdEqZ
        3MHo1lFSsXMsSCGHquyhHWGzzVShzlSNUBT1BjvVGK6VaZ4501JPlW+/PapDT+zu
        z3KGCItVi8Cp8gdMzB6krWSRDsEDR8MaBIIrA5tVWv6IS8hneTiSVouSaBLeXSZ1
        xVXMf8musINesp37AcDaA==
X-ME-Sender: <xms:lDD9YmZbo5eeogcRZ8o3c8vXsLJXWgJr3XiBzG8u8rUpSV1m-4u7Uw>
    <xme:lDD9YpaqqVLZ4ydIuyQZrBEkgD21D2ZHpzgbR0NwKLsN46BvaXWXTfGf9tsJ1eb98
    ZruKsKD2OyWMTYudtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    vehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevgefhieevhedvueekvdettdefhfdutdelkeff
    keekfeehiedvhefgffelieelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshes
    tgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:lDD9Yg--KO9Qs3IYTihFQpI2iFJ106q9Rbwx38wDb-XvFaa1ON6mMA>
    <xmx:lDD9YorS0eumgWZIUlAKw_TP1tQDASzpDDm_GGCjrz-jr4UYplq3pw>
    <xmx:lDD9Yhpl-uq64WcCFA-HD1WnJRhDOIgpA5wJ3StKYBHnFnvkVyqG-A>
    <xmx:lTD9Yidm1hxhOcRgK-2Vzm4avyXqyQprgcLCb8XVK3G53yyEVov2fA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D8AD01700082; Wed, 17 Aug 2022 14:16:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <c7b102fc-84d7-47c0-b017-50609687f9a4@www.fastmail.com>
In-Reply-To: <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
Date:   Wed, 17 Aug 2022 14:16:32 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 17, 2022, at 5:52 AM, Holger Hoffst=C3=A4tte wrote:

> Chris, just a shot in the dark but can you try the patch from
>
> https://lore.kernel.org/linux-block/20220803121504.212071-1-yukuai1@hu=
aweicloud.com/
>
> on top of something more recent than 5.12? Ideally 5.19 where it appli=
es
> cleanly.


This patch applies cleanly on 5.12.0. I can try newer kernels later, but=
 as the problem so easily reproduces with 5.12 and the problem first app=
eared there, is why I'm sticking with it. (For sure we prefer to be on 5=
.19 series.)

Let me know if I should try it still.


--=20
Chris Murphy
