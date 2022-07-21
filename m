Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925857C245
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiGUCbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUCbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:31:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7357748D;
        Wed, 20 Jul 2022 19:31:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 09E3C5C00FD;
        Wed, 20 Jul 2022 22:31:45 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 20 Jul 2022 22:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658370705; x=1658457105; bh=LSlSR+cLWU
        ESK/7hyMaqascoi43oh+3X5GZAXEbeqIY=; b=pad5Gk+fbTZuv/Xr3px+Jw1fWU
        5vg3kjN4PXjpRAL128Uc1thu88Vjs3TVw5M30DpUny3NVKpN9XDHHZfWcgdKy3GV
        0O+L4+0TeDyzFLT7S2XvlQWJ+B29MuIBxZ/sW1QthKsZINbRTiUGHUviKD+rvAOh
        x74jbWN5g1Y3DozTMoK3JG+Fw0VGABAZBnifgxu6ROcqbSmsR7O4mixmLYM4+YW4
        KRcn2zVMb7I4pkJhtVKD6lFydFgixonpSi0UJVr61Wh4tL85rgAj+00ptaeyJIjK
        4Ypjf6TWt7h4VlC1F5hsgujAaoxRwubhyw+pGdPMJDxuOmUjRMI9YOluj0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658370705; x=1658457105; bh=LSlSR+cLWUESK/7hyMaqascoi43o
        h+3X5GZAXEbeqIY=; b=F/iX98KIHb72fhXkDALC8nKuRAg1Nk93yJg8Yz5wn226
        vZ30f7FU1IxN9UOXLsal372qI5LCw7NNhiQKqBTwrarGzdcmoAOsNmbjGMyUwIIu
        JUqAysBmVLmMPtXIpDY18dOvmvRkNDlwbpmZjl9kpJCx042wG/NSXQrkKo9dRCLK
        JGLW2hzpioPp9geMM9hre+MyqIwdouILjutnsfaXjCgfB4WW4Yt2BWgwDr3uob7m
        jzTJ4/hpVA5ZvFkSJI7OuRwOk1JXDJEmaTQXzqdW8tVfQ2JK+nMwJd9IpTy9haK+
        +Gzt5R9xlPmyrkG26EdN/+eXTsB9iFSvIKc0owQBuA==
X-ME-Sender: <xms:kLrYYvR7CQlHvq5fayk64y44238qaSKN0Tj2NTQLDhzJH9yUAKWJXA>
    <xme:kLrYYgwbTYNErkUu7YjvAPOaxLoej42Ca5KiGKnH3emkSgobJZpniIkHRVGZd_nye
    1oSYgGTdOxneOLUIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:kLrYYk2kkXwRBrOynAa8GSlLIq3TDRff64bs8Mq9_paWK45TlefBmA>
    <xmx:kLrYYvCOf2X023HYDkaCf-xSpl49Qi6pg2OfWbtJhD3EAjgZtGyuBA>
    <xmx:kLrYYohAP_OYHweN3yWn1wtBmUOZ9vV6MTdJIS9df_-KPPqyw81BBw>
    <xmx:kbrYYjXGXbQoQ3skrJpnLoFID6jo9ScExJ3oe5WQT96IbEO7k6j1WA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C237B170007E; Wed, 20 Jul 2022 22:31:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <99337b7c-22ae-4618-a890-b0ace39bfe8a@www.fastmail.com>
In-Reply-To: <20220611095828.1090-2-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
 <20220611095828.1090-2-aladyshev22@gmail.com>
Date:   Thu, 21 Jul 2022 12:01:24 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Konstantin Aladyshev" <aladyshev22@gmail.com>
Cc:     "Supreeth Venkatesh" <supreeth.venkatesh@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: aspeed: ethanolx: Add correct label to flash device
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2022, at 19:28, Konstantin Aladyshev wrote:
> The OpenBMC code update infrastructure requires BMC firmware flash
> drive to have a label "bmc".
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
