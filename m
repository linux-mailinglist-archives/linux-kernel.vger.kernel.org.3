Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7F4AEAF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiBIHU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBIHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:20:55 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 23:20:59 PST
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664EC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:20:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id BBC9D2B000B2;
        Wed,  9 Feb 2022 01:22:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 09 Feb 2022 01:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=uYUsC8D7J1WUo+J6bx2eQOdH/dy8+lejaehWcp
        k6GBo=; b=Cy6QfLXNK9ddNsaNfHFSY5yUDcum8yl8skzZav/ud1bLyWJm9i+H2N
        SpS9vCCPJNz3EhdX6R7bNHE5TwnmuGx8hrIQD6Ke0lkHiLJbv+2D2ISJOIreQAHp
        zlTudmXfA6fgBKWeb4RfttzjZQWairwAi8zEOMgLFJxJY266OitiKMn/iK2MofG9
        Y032ZMNc6VTvKp3gwHwaew7HWyGX9/QdIbBhf0DRD1wOLtnReaJ41R42SS3SmjEp
        oq75I4DXcgyUGeXPi/hzmuRgvyhviRaNm0HYMkjmizn113WV1YDKi6lxcqn1pXRx
        LZ8ZfuZLRFyiOfWDfcDjJKW40pLzzwHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uYUsC8D7J1WUo+J6b
        x2eQOdH/dy8+lejaehWcpk6GBo=; b=l7NWThywEGOkQ9fm/3BjYdHvjllOQdFou
        P/ktkxkoeOk0+UMQHxyqxLMDe00JvlZvokZFpnP0mutFa97ynWnGo8+GsGhBd7bQ
        ePyOYOQBz4EOerYi1TAcjt83sS9D43+QnxOXJKeFixmU7+VSypaXxwfmSR1/UvN/
        lx5NaMEW+l+WJtz1cXJ3QC0HjFm7vfzkWSjLntz67OFr2sSV/QDMd35z/GFGDkZP
        M9azGwsnoafqZ6IIIiQStgCwZi47lD8Zr5QsdqzprA/ndsSUMehWXwb3ul026Efp
        V9bPK/e6oTQYP5pUGjW3s6EtWzDNaG+jE+9TgsAf1c4cdmY6Lddrw==
X-ME-Sender: <xms:ql0DYjgm5-gK4DzlRnIRleaAZC7m7XfnMU0Wlq6trKL31Pi3Sq5Rhg>
    <xme:ql0DYgCyV-p2SLv-O5gDtlrN1S3jpArysnlnvCNzIc7sOdxPGq1OXKpuLhDiz_QWv
    zMxZJW8wGosxCtkk5I>
X-ME-Received: <xmr:ql0DYjEio6Dy3MT-mF99-GHGBP28-voGwekJOer4xggVCP-L0OsKD92Md0SdHKFJTpfVeq7HHyhYLcoYNuN-9MqX0ZWlEZHgvuZP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheekgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgvrhcu
    jfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvghtqe
    enucggtffrrghtthgvrhhnpeehhfehfffgheelgeeuudelhefgvdefveekudevjeevjeev
    vefggefguddufeeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:q10DYgQBPT5DJBJQNWB7ExStByEz9364Q8QPDZ87bpmbNMuv3Fiozg>
    <xmx:q10DYgzL1vK-niLoRTf4bygNcsNSdYQc-JjR5Es2zE7QIPnGK_QGTQ>
    <xmx:q10DYm7Y13cav-dx07gXrcrRCEreoogrWv6gjomlhZs48N16o2KPGw>
    <xmx:q10DYsdqZFrXGAgzPknSebDMoUCygwA0YN5qVx64BCVCAPD1RcshgxSOYoM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 01:22:31 -0500 (EST)
Date:   Wed, 9 Feb 2022 16:22:26 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] Input: docs: add more details on the use of
 BTN_TOOL
Message-ID: <YgNdokzzATwy/57P@quokka>
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
 <20220126161832.3193805-13-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126161832.3193805-13-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 05:18:32PM +0100, Benjamin Tissoires wrote:
> The HID core stack used to be very relaxed considering the BTN_TOOL_*
> usage. With the recent commits, we should now enforce to have only one
> tool at a time, meaning that we can now express that requirement in the
> docs.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  Documentation/input/event-codes.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index b24ae7d292cc..41b1fa647dab 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -137,7 +137,10 @@ A few EV_KEY codes have special meanings:
>      code should be set to a value of 1. When the tool is no longer interacting
>      with the input device, the BTN_TOOL_<name> code should be reset to 0. All
>      trackpads, tablets, and touchscreens should use at least one BTN_TOOL_<name>
> -    code when events are generated.
> +    code when events are generated. Likewise all trackpads, tablets, and
> +    touchscreens should export only one BTN_TOOL_<name> at a time. It is

s/export/set to nonzero/ to avoid any ambiguity with setting the evbit on the
device vs setting the value to nonzero.

> +    however accepted to switch tool in one EV_SYN frame by setting the old
> +    BTN_TOOL_<name> at a value of 0 and the new one at 1.

I would even s/accepted/recommended/ but this LGTM to me, thanks.

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter


