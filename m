Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3297B4646EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhLAGAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:00:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54967 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhLAGAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:00:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 866915C0094;
        Wed,  1 Dec 2021 00:56:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 01 Dec 2021 00:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=l
        o8mU9kXYXfa+p+Bapf1IJs4wvyj8j/AWtM7bGAUlM0=; b=mxz2PFtqDSGJs3Hdp
        vaueAgj4AXLg9pSSTnWorJK8yJj8KWyXwiftzzJCaJfM6jPKM6uNDlZzeHks805c
        yQS+ZCRWdIMaVQ7sdfRDoHr681tn/9bOc/h1D2w23NwaTM0H3HS3UwEMWlin6lRG
        eUfy2ZYYnctUsDzmjfmPIDnTkVr7gseBDQcgiQbXjVGXg5XszwU9JZZrxTb/kviC
        L1eEI6tJQ6tLOUhT/dkFPg5XpGVjFM8z77HJ6d+mH7+ViIpw1aVsjq/xRtTQv+xC
        tlvNMnnKBZgzp5xOW9qgRHKIagj73REJM0mmmi+CAmFoatv/5NeyH3eT+BWd4DfQ
        5y3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=lo8mU9kXYXfa+p+Bapf1IJs4wvyj8j/AWtM7bGAUl
        M0=; b=DupXmSP6uHUHqxjCFlQPKyHt7amIUO0UtFekjdMMiYxdgx8zg1E6ybWYl
        TLvhArXR3n7p5TCXY9ise61lmYH88iWUBPODc99cAfzctUwxJbn1EocY/NP5Q1bG
        wOPunrswhXw+ml0puMnOQyQJtUprhqFCTBHG9mKsr2MC78pZ4kfGJJh4a1+C3Mal
        ONtRBA/J0Xtmy3hYLCxuhsdHWtqwdzTVpkWmKwH9oU9VgYniFbp49IP7EHp7IknX
        yqN/E3E3OzcSnJxtBGJ/1HiNW0NyWGzeMn1coq/xFfMvn36CnqrpvLA+Y3VO4vUI
        RlsksLqjNd8GUn+8QOnzODxETzGJw==
X-ME-Sender: <xms:oA6nYa_qvVLP8lPH6nH6oCXBS8142xddBao_zeGGyg_k0CWvfmcKng>
    <xme:oA6nYatCAD9OnolQo8zs7VN6IJa59bEdLMXKGSUHaRRUybKUzavz4FTTC6BwEVWnN
    W0Teq3jlPzNJnBjVCE>
X-ME-Received: <xmr:oA6nYQBdBsY8_cz3sQC6GmeS3VhlvuI4MqyoF1JCrOrd7yBVJxiur1qvO421NXSAZc0LCu-KTa7AKqRjnw7X1qPBzixaGzxpnTwN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddriedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnhepffefffekvdekleehledtffeihffhiefhleehtddtueeg
    jeefhfetledvgeevteelnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpd
    hmihgtrhhoshhofhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:oA6nYScFJwmhUASXPurD94zkUY6FSX_laxTg59sCeYmrFIO0cOZcrw>
    <xmx:oA6nYfP_dcKfIL5aaxeJLb6yUKk_ZIHBy5BIP6ehZMTTLiGoXwXnIA>
    <xmx:oA6nYcnoHP88rlEYmLKkPrAH48y4dLxAWcn7UgzCiI1hvOL57aSiQw>
    <xmx:oA6nYYo-BDmNQPl2WmtWaQ8Z4gDC-z0ygQ8VbIYADV8gFBfqDmI0Qg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Dec 2021 00:56:46 -0500 (EST)
Date:   Wed, 1 Dec 2021 15:56:41 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] Do not map BTN_RIGHT/MIDDLE on buttonpads
Message-ID: <YacOmYorwAIB4Q3c@quokka>
References: <20211123191238.12472-1-jose.exposito89@gmail.com>
 <CAO-hwJLB8h6fQRF8UjN3rER_6xS2Shi3ffEr92PhkVCijtYRpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJLB8h6fQRF8UjN3rER_6xS2Shi3ffEr92PhkVCijtYRpQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:39:02AM +0100, Benjamin Tissoires wrote:
> Hi José,
> 
> On Tue, Nov 23, 2021 at 8:12 PM José Expósito <jose.exposito89@gmail.com> wrote:
> >
> > Hi all,
> >
> > Historically, libinput has relayed on the INPUT_PROP_BUTTONPAD property
> > to detect buttonpads.
> >
> > Since buttonpads are expected to have only one button (BTN_LEFT),
> > recently we added a new rule to detect buttonpads: Where a touchpad
> > maps the BTN_RIGHT bit, libinput assumes it is NOT a buttonpad.
> >
> > However, this change leaded to several false possitives, so we ended up
> > reverting it. For more context:
> > https://gitlab.freedesktop.org/libinput/libinput/-/issues/704
> >
> > And for a full list of affected hardware, HID reports and bug reports
> > please see:
> > https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/726
> >
> > My understanding is that buttonpads should not map BTN_RIGHT and/or
> > BTN_MIDDLE and to avoid it I would like to fix the required drivers.
> 
> As long as udev intrinsic is happy with it (and it correctly tags the
> touchpad as ID_INPUT_something), I'm fine with it.

fwiw, udev's builtin input-id touchpad check is
  ABS_X && ABS_Y && BTN_TOOL_FINGER && !BTN_TOOL_PEN && !INPUT_PROP_DIRECT
it doesn't care about the actual buttons so this patch wouldn't affect it.

> Also, you might want to point at the specification regarding button
> pads: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection#device-capabilities-feature-report
> 
> The way I read it: if the device exports the Button type value
> feature, and it is 0 or 1 (click-pad or pressure-pad), there should
> not be discrete buttons.

Yeah, it sounds like there *should* not be any buttons but 
There is nothing to explicitly forbid extra buttons for click/pressurepads
which is probably how those devices get past the windows driver
implementation.

Cheers,
   Peter
