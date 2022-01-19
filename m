Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEE4936E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352865AbiASJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:11:12 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39863 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352858AbiASJLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:11:09 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E2B173202112;
        Wed, 19 Jan 2022 04:11:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 19 Jan 2022 04:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        F8MxcNmLbvsLd8ilfryFjFcJsELc7SyqXZ3lyhwudlw=; b=VGxZdy+d2f+pXpaw
        4Lwmkhs9i43PfMrUvD3H5d90vl1wVROdW3mPM3ZVUiX0uwFSW3j34Sx5T2DgAU17
        NmcDpMOGZntPmZrAeYj1v0W8ihIj3PG+/orvdahIZXjrDMK/AahsSpNkagxM4bNF
        bAxDDiFvUaPmuvydPnC2mAdSWjWZBVAN+OwrPHBX/NOf11aZfD1MevUNLnKxlrFC
        yLYhSlGtJRrk+axOUZM5YMLZkwPwsibIpoBPtp0Hx3Od8fasTC2kxGsFIDbkThfX
        XsIgVFeFr5/7IKRRS4Dh0WeVwB8PiDaGWX6iIRgQiDGH4bAmq6NuM9XfnYUNDEh5
        VjVhoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=F8MxcNmLbvsLd8ilfryFjFcJsELc7SyqXZ3lyhwud
        lw=; b=gQLdUDHZMidEsvUHpsZF1/Pw5tOEY/q9o9WLcuaRqjpz8YjeKATtl/Ktw
        BIIEVPbKBfH0TlS25AjEU0dLO1tje6dy3calhGHEBZ297g6FJBEzfuJXSRfdbnxr
        UTB17I6kngqxZ/f/IUZpVNT2NpiHTqPeyhTEWoTAMr0Kzth+Twgqn7y3Pae/WkXK
        vuNPIyM3hhTFk/l2kZjw5XN+6P9pHvvxLpqZ/7B5QBraXsx54f8Mto/K2dfpr6W9
        N8OfXaBUM6Bzb7aMoPMwfWfJwq4UihRXbvKLjA/0FtS03FWDsUjAxO8LXjPderT6
        R8dFVRMy601sRQ5BxECZ2uc/YQVjA==
X-ME-Sender: <xms:rNXnYWTawe_vfzd-vJTbVoSpw4-piG_y9FToZc_AvQNJjbYSy-naMg>
    <xme:rNXnYbzw5ZO2soiAO5F5G1q0nXmdDFeIDDGgGv6UTaxFbrtP8UFdsAmlfnWpgbu1-
    KvLno0hx7cik3w4IfQ>
X-ME-Received: <xmr:rNXnYT3A4HufDxKHEUfZyN0d5dG3MRzZ91AqU6_zXf342dIJ0nJhvG49Jr2G_X3W27btLRd55xbyIau-DbxncpRTa-NOHe7zEta7bkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertd
    ejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhho
    rdhtvggthheqnecuggftrfgrthhtvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffje
    ejvddvudduteehhfefhfefgeeikeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:rNXnYSAUiA6v_h17V9jckHuojx7z-eIvN0trA48ZnbPhopEpipKSQQ>
    <xmx:rNXnYfgVyfthvRGL0aKSyhKMT_2ezW9W7IwXhv3ltw0P1yB54vWrjQ>
    <xmx:rNXnYerG4a96VKOgcQcB1ztF4H6amfybKSVObaHr416YrhNuE7Wozg>
    <xmx:rNXnYfgh3eDtsBLz7Tms6Wnb3huL2RETpaQOCCkDMzpor8GZB-QqCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 04:11:07 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        mripard@kernel.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
        airlied@linux.ie
Cc:     Maxime Ripard <maxime@cerno.tech>, emma@anholt.net,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH] drm/vc4: Fix deadlock on DSI device attach error
Date:   Wed, 19 Jan 2022 10:11:05 +0100
Message-Id: <164258346063.31836.9424358467323476627.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118005127.29015-1-treasure4paddy@gmail.com>
References: <20220118005127.29015-1-treasure4paddy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2022 01:51:26 +0100, Padmanabha Srinivasaiah wrote:
> DSI device attach to DSI host will be done with host device's lock
> held.
> 
> Un-registering host in "device attach" error path (ex: probe retry)
> will result in deadlock with below call trace and non operational
> DSI display.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next-fixes).

Thanks!
Maxime
