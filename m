Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5758B11E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbiHEV32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiHEV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:29:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FEC1AD9C;
        Fri,  5 Aug 2022 14:29:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A72695C01E3;
        Fri,  5 Aug 2022 17:29:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 05 Aug 2022 17:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659734963; x=1659821363; bh=EfIpyjOOcf
        4jZ6FdNb5kXcSL5JG3gIWiATWUoT9UbSo=; b=g/rB3Mk7OZyOV7qNxZ02rIJZU/
        CD+6g+7aPLfCBWXz2DFpNRp/p6IZhuy0hfMySxoBHu1l36B8+8NaqGl3W0o9SJFF
        CX+AsO00Sxgh1pOKecu4uDp1gLFuXF71o219UTN+bBd3g99QlZx7ojns6CHtlxr2
        KU36NSi0K5wsNSDjXAyo6dqmuPOyJuIpvvQK9QQDtcAoNbpqUVmWAc9BgRYUI3M8
        zQaUTlB5+beUDJ1HRi1IMIDzh84kMeNCeVCAjLS3CkHqd0AsKMbKiFaoVuVVo3xY
        zTTDdTy8+FMIM8fRd5kRxAg3jKZoBvmtGg/qoQyOxr7x2/5owmx5gRlrUNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659734963; x=1659821363; bh=EfIpyjOOcf4jZ6FdNb5kXcSL5JG3
        gIWiATWUoT9UbSo=; b=CF94houWiFG+lmfWQBJVsDopxR8Ark49aTNy3SNhYgyb
        FOiNhZbGM45X/6+s5/fXcdniwIA1GUPjKYWFWA7t5wfikog9TrHg1XO2SnopeD2X
        l4qCoVj7Mfk/4/lbR/O0+pBkz1oNz9FJ9BkYpKkM5wEGiXmFf+spe7KTIfuDuyYw
        YyKUkHOYLhqSBYe+oSNHSmZKFWChQ7mWFPM+uf2uMJBsr6O64xK7JX8qJKFxV/y4
        Aqy55tfgnSt36btanBFmriSDU7KqgYjmsS681XvQ4YRC4JmW9vtBm1MwenC2I6lM
        SxIgBOL85239ZL5MVJlDTkhgNLJT6goaLODbdStDLg==
X-ME-Sender: <xms:s4vtYlJPeepfo7L_J27IFTK75A8Z_m1mMyESHIMHfrhvn6iV3Gc1GQ>
    <xme:s4vtYhKOeFY5nCVrvcFqKzjkJTHE7E5-Kf_kIZMLk7ScpsckewySkw1PeaKMvA7CJ
    c5FeFv-D7rRHawqs6w>
X-ME-Received: <xmr:s4vtYtsB8ayZ7ECrJaldVDoGgjhWlMfTaUa7-V7aH95yImirX4yfg-OaabM5_SyU9QDTwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:s4vtYmb4Dw9dtrqZnUx9kW4OlZHI3zo-etQySUzV_acUC2JaIoTkyA>
    <xmx:s4vtYsYrRHFizcTAfo890bxj7ub32kmMci_duTxzn_IijUGh0Z1Ewg>
    <xmx:s4vtYqAjyQj67d5YfM8qdgWFsIBIlOPQ-ID2sF0cLNKvEPEotNh0rA>
    <xmx:s4vtYrmrYvsA1LwMjuK4IZHJYjzho_xhf7lgV7Ofihp4zUfCajuFDg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 17:29:19 -0400 (EDT)
Date:   Sat, 06 Aug 2022 09:29:06 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 3/5] asus-wmi: Add support for TUF laptop keyboard states
To:     Pavel Machek <pavel@ucw.cz>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <IOV5GR.PZU2YHNSNKYD2@ljones.dev>
In-Reply-To: <20220805120859.GB20036@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
        <20220805081909.10962-4-luke@ljones.dev> <20220805120859.GB20036@duo.ucw.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Fri, Aug 5 2022 at 14:08:59 +0200, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>> 
>>  Adds two paths:
>>  - /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state
>>  - /sys/devices/platform/asus-nb-wmi/keyboard_rgb_state_index
> 
> Patches 2-3 -- we already have pattern trigger. This should use it...

Can you please provide more information? I'd be happy to use it, but 
because I do this in my free time I don't have the best knowledge of 
helpful stuff that already exists - so far I've been learning about 
stuff like this when someone like yourself brings it up, otherwise I 
try to follow existing code patterns in the source file.

Many thanks,
Luke.

> 
> Best regards,
> 									Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.


