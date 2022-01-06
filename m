Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C40C486540
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiAFNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiAFNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:25:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F859C061245;
        Thu,  6 Jan 2022 05:25:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9BE61BFE;
        Thu,  6 Jan 2022 13:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7BAC36AE3;
        Thu,  6 Jan 2022 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641475519;
        bh=Qg1lAw3HV9Pyh+Etyu2GDYQ2qErqgznXZ6FUS+WxFO8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=V6v/Q2enmnYXbfiUrRN9ouN7n3hkeqmF0nO40YWZutuzGou8hYkAQhEIql28NWXv4
         zrJcp/MY+wKGgFM6eIic4bUJl0Ku8Nb+HTEppigOrm2ZgZlFU9pH63Anb1C4uqEs5C
         U51iuSTU1FwTnuKLb6+Awea14Wy7v4N12OfeH+pI9yfFbiAiYGwi/wI+QkRje05VuZ
         zoLdMGg/Mt0S+Pq755z3TEObCxho8XgNDN1Vh/Nwa8MHkg22iCudlBdU21BjcSxy1I
         4bYyXir39KfZlqbOtxo85mUnXe18A11DDBNNVbFMv/DL4ErR1FPw11ciCTDh382P0N
         8wxxh/RpLqPmA==
Date:   Thu, 6 Jan 2022 14:25:16 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kortan <kortanzh@gmail.com>
cc:     benjamin.tissoires@redhat.com, s.parschauer@gmx.de,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: quirks: Always poll Anne Pro 2(C15) Keyboard
In-Reply-To: <61b44512.1c69fb81.a2de3.f58a@mx.google.com>
Message-ID: <nycvar.YFH.7.76.2201061424460.16505@cbobk.fhfr.pm>
References: <61b44512.1c69fb81.a2de3.f58a@mx.google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021, kortanzh@gmail.com wrote:

> From: Kortan <kortanzh@gmail.com>
> 
> According to https://openannepro.github.io/ap2_revisions, Anne Pro 2
> keyboard has two hardware revisions, C15(04d9:a292) and C18(04d9:a293).
> 
> Previous patch submitted by Sebastian only fix the C18 revision. This
> patch add missing C15 revision support.
> 
> Fixes: ca28aff0e1dc ("HID: quirks: Always poll Obins Anne Pro 2 keyboard")
> Signed-off-by: Kortan <kortanzh@gmail.com>

Thanks for the fix. Could you however, please, resubmit the patch with the 
full name, as outlined in Documentation/process/submitting-patches.rst ?

-- 
Jiri Kosina
SUSE Labs

