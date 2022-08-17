Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA25971B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbiHQOjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240285AbiHQOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:38:54 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9C39C8F4;
        Wed, 17 Aug 2022 07:37:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6DEC9580D68;
        Wed, 17 Aug 2022 10:37:57 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660747077; x=
        1660750677; bh=lvuuMfAWpplBEzLm5cL1HHt3BK8ecTFvKbdlnZbzzGE=; b=s
        nlndHuQ43Rqu7mGPh+CUHVt8JC8IYhT75XZ4CCLhURXZ6csIY2Nl8CuyAn8dtQAy
        kv4QWo0dTEIQL37BLumjLXey+d3IbvvTowkEOk11QR3HmUAhO9v/nAby5AHbxPxG
        p6ylZjezTpyLbZ9C1Ca6nRv9XL4VmOKqblA1C7bWJ/yzRBJeL3xXuwQSoKw3AjyK
        X3ZHGQDHDa1hNT1byFFEfxJUQhrb95C3OmiWBRG9hAD5+uS8xBihCmjbhI7BVs9o
        hrZNiKJy+93dZDDpuqyRw7DreVnjE25RenJsZkItgxfTcpbgqZcHTof3x9v9x69K
        ruAUl61CGoA890pWFJAGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660747077; x=1660750677; bh=lvuuMfAWpplBEzLm5cL1HHt3BK8e
        cTFvKbdlnZbzzGE=; b=xUijTkXrQOBVvyWsRmpx9vdIjuePl7LHzXkEOSX8lhCF
        /muWjienfwYb9wStRHPag6hgW5BGZVv7P7wigZ388FtqAnK57IjmTIABMovcO2y2
        IGbIj3c2tvQy1Zem5Q0lAGl3y+t2duf1vpK+ueS60ksD2wsKQ8c7GVG0Uy4N5lyu
        gAg9+Nh3hTIw1QdfgoNa2tzzYZrlMzV+2snOuHDcuD7etvUZvGnMHTrKM2U4//3w
        Yjqx9/6ItLKQJuZy3bErhfTDywm6Pl880YPRTeEmGbbcPZMkcpVkaLLK9fSNeu+I
        L4Hnfd76cSFzxMCrTap23Jb5YFGjsm8X6odZEhZxgw==
X-ME-Sender: <xms:Rf38YnLQtB0mfZlREJhexKFzBzdLKIoewyJX5UrdPXZ7hd3cjQ2RUw>
    <xme:Rf38YrJIUWa-rJH47cGPA-aNaSO3cUF6pvfbDPLVPhux0IcoMK4O0A1LV4-Jo66pt
    o4O4jtfAbEq17Dy82o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:Rf38Yvs3ZO9dcnvK6gwpuMi--GCPdmHaYfyIhjyRCX_jHMHmyS96Ug>
    <xmx:Rf38YgbEPoKRdIgr9C_6i-fBUGlHGpUnzBNTTxkfvFJ1XH4nX0j-5A>
    <xmx:Rf38Yuaeov41gIWq3qnOgyNlEzt7G1WOIuqUHrQxDlrATLjXhT2foA>
    <xmx:Rf38YjM2n9O9pNoR-qPrByf_BBm1oVlWJHDBC8gFGlOYJH4s9awoeg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 14F4F1700082; Wed, 17 Aug 2022 10:37:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <63ca1776-764e-482c-a4f4-0f3616be83d5@www.fastmail.com>
In-Reply-To: <20220817114933.66c4g4xjsi4df2tg@quack3>
References: <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
Date:   Wed, 17 Aug 2022 10:37:35 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jan Kara" <jack@suse.cz>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
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



On Wed, Aug 17, 2022, at 7:49 AM, Jan Kara wrote:

> Another thing worth trying is to compile the kernel without
> CONFIG_BFQ_GROUP_IOSCHED. That will essentially disable cgroup support in
> BFQ so we will see whether the problem may be cgroup related or not.

Does boot param cgroup.disable=io affect it? Because the problem still happens with that parameter. Otherwise I can build a kernel with it disabled.

-- 
Chris Murphy
