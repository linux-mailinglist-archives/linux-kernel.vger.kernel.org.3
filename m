Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161E59087D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiHKWCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiHKWCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:02:05 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278567C9B;
        Thu, 11 Aug 2022 15:02:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9942C5C005E;
        Thu, 11 Aug 2022 18:02:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Aug 2022 18:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660255321; x=
        1660341721; bh=CTZyQu3k2T4ygetTKcwPn3NWnNrR4oMoRyDyOnzTuKk=; b=p
        JXlaIsTzR3RliCOqfus13+e4Mw5GdwEzUtdCgETjH7tCHCuoojoQjiiBbJlQGEHQ
        +DrYuEUM9trb5reHKBY0N1WqRTxfaGfDk0kkWQQezXC6KGrQOQTLt2cc8AKKhrXb
        g5qiGCSSgb5KJxQKsfBctVNM8N+UjO/WdsGt37o1TSXKophZHQPOd+WF/mqQh8sK
        qNPbsV9cKT1RsAdfLDQhRH97Vvz7YQ0hQHv6bK3uaNhiuh05QOifu7ICbM9OORoI
        vFMh/h0+0IB11ilXad9kDhX0KLg2Pk6QjWtxEnO7xazXLEaLsf1Hh3QHycuQCOCK
        TPse55UkdICxDp4v1qJEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660255321; x=
        1660341721; bh=CTZyQu3k2T4ygetTKcwPn3NWnNrR4oMoRyDyOnzTuKk=; b=A
        YnrfKvRehig5zjxHamNNXXl/LSZYPvSj3loCapKsFK60JBxRqY1s/XLKvLkrfz8q
        bjpHiDptsCguKnMbqc06waPX+tZNrzlBLOZl2i8FoV6+Z7r2OMimYxcc3ZuUecND
        PDXRD9uc17lFNPSx00dfczc1kb81yNQPLb9Q9Pdv5i61hmbw96rnKLN5F6BDz72z
        PxftOR/vDJuKePK+R6ns3zrfRVe6mr4CRumug3ku0HdDYSJn+Wb/D/KHCA9Uya1L
        g1NTdlNhZSkj3sTJTiKf0OK5w0bSI0DDO2+eLCfpe0f1Rr7g8ojzfev4Q0eDeRFO
        uI6f6rs7oWm+20kr1dpmw==
X-ME-Sender: <xms:WXz1YjjXGEr5NWN1FyDWKptOktiGCLfyr3c2fCCCfunWqtMOZOb-sg>
    <xme:WXz1YgAPhh1jqe1014656hDUzvNPc-0dEAES0jse4PYn8EXtUhNWMpR2pKdDJORBo
    0NQfpp1jIINhensm9E>
X-ME-Received: <xmr:WXz1YjG77s4BpoqMX0F4_yoPHF4C9PyxcuO12v5o1EgGGvTZ6OWWlweH91MfA7UE-blEQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:WXz1YgQm4-sx7vJVUhU-LFQwomGc1cBNJaJe6jTcoXT-8nTRwiP3gw>
    <xmx:WXz1YgyM0kOaC36wy9IWDOEWWsmklJkBPnFL8n1WF97u6g06z-5GJg>
    <xmx:WXz1Ym4Fbw7ag1JDflznlDc8LdbLipobE0HDs8RCyxMIymVGxV8MfQ>
    <xmx:WXz1Ys9qPdGlCfjTo3hhFGbwRntUJnyk46_9XQ03bJAzkPzBlaqlmA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 18:01:59 -0400 (EDT)
Message-ID: <9ed62983bd03ed26cdb4399dd69b4096e8711fa9.camel@ljones.dev>
Subject: Re: [PATCH v3 6/6] asus-wmi: Support the hardware GPU MUX on some
 laptops
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Aug 2022 10:01:51 +1200
In-Reply-To: <7365d41a-1475-118c-96a8-6ab927bda5b7@redhat.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
         <20220809025054.1626339-7-luke@ljones.dev>
         <7365d41a-1475-118c-96a8-6ab927bda5b7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, 2022-08-11 at 15:53 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 8/9/22 04:50, Luke D. Jones wrote:
> > Support the hardware GPU MUX switch available on some models. This
> > switch can toggle the MUX between:
> >=20
> > - 0, Dedicated mode
> > - 1, Optimus mode
> >=20
> > Optimus mode is the regular iGPU + dGPU available, while dedicated
> > mode switches the system to have only the dGPU available.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> I see that you have replied to this that it needs more work.
>=20
> Besides it needing more work, ideally this should hook into
> the existing vga-switcheroo mechanism for this. Can you take
> a look at that please?
>=20
> I think this might be the first non GPU driver doing vga-
> switcheroo stuff. So this may be something to discuss
> on the dri-devel list.

I'm not sure how this would work. In typical ASUS fashion they do non-
standard stuff. This switch is a basic toggle that requires a reboot to
enable after writing to the ACPI method, after reboot the dGPU becomes
the only visible GPU on the system and (this GPU) can not be suspended.

In short: it toggles the laptop from discrete-only mode, and optimus
mode, requiring a reboot to switch.

From what I understand of switcheroo it is more to manage having dual
(or more) GPU available during runtime, and manage the power states,
offload etc.

I have a vastly improved patch for this prepared now. Because of how
the actual feature works (and the above explanation) it must be under
the asus-nb-wmi sysfs (next to the dgpu_disable and egpu_enable toggles
which are also unusual and non-standard work-arounds of Windows
issues).

Kind regards,
Luke.
