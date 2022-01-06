Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD5D4864F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiAFNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiAFNJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:09:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C3C061245;
        Thu,  6 Jan 2022 05:09:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5061FB8210B;
        Thu,  6 Jan 2022 13:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F9C36AE5;
        Thu,  6 Jan 2022 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641474568;
        bh=AONPHdP8zVkGQsvq1+4Kl9K08uyYX7tVRt82KdJzkmQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YC0ifejXxYTiYOrVmXvm9PA9+hbZiS0BqTyGcob7EdIav69ET2LdDiTrKFakADrnj
         4hxEPvys1ONP/pg1lHMZ2Oync0+7gFt8KQONcf3dr++oUXP9PaniZjz/ca94QHrx3E
         RgJertYik3J5I1TAySKYZ2epRPEAf3v0tT1WLhLMFDK53jn16UAWgXOfWqhmOTLMMk
         sy4Mr+paZf6N6MMnfXfECLsyL9AsTeMachPk9CL9154UiUarLw+UspN0tPsJ7ivCX8
         0lckiuUiNyPP2QXpbZ9n9b4nXPNNqZUx3ka8UfuWByeQShTsuraKxzDQBoSIAVIQMG
         cQjzp9fU840VA==
Date:   Thu, 6 Jan 2022 14:09:23 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        benjamin.tissoires@redhat.com, peter.hutterer@who-t.net,
        roderick.colenbrander@sony.com, pali@kernel.org,
        rydberg@bitmath.org, nick@shmanahar.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: set INPUT_PROP_BUTTONPAD using
 input_set_property()
In-Reply-To: <YdPoEI5+fdr0MS8S@google.com>
Message-ID: <nycvar.YFH.7.76.2201061408590.16505@cbobk.fhfr.pm>
References: <20211202110807.6783-1-jose.exposito89@gmail.com> <20211202110807.6783-3-jose.exposito89@gmail.com> <YdPoEI5+fdr0MS8S@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022, Dmitry Torokhov wrote:

> Hi José,
> 
> On Thu, Dec 02, 2021 at 12:08:07PM +0100, José Expósito wrote:
> 
> A short description would be appreciated.
> 
> Jiri, Benjamin, do you mind if I take this through my tree or you would
> prefer having this split?

Please just take it through input.git with

	Acked-by: Jiri Kosina <jkosina@suse.cz>

for the HID parts.

Thanks!

-- 
Jiri Kosina
SUSE Labs

