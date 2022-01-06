Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1D4864D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiAFNCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiAFNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:02:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D02C061245;
        Thu,  6 Jan 2022 05:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0358A619FA;
        Thu,  6 Jan 2022 13:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC54C36AE5;
        Thu,  6 Jan 2022 13:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641474128;
        bh=1YOknMCp6fR6BdY/+O5hZo5jtINgf82tgEzAgkKiN8k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TN2nlHMslazNWw/KgBOkg6ErGyNIagJyMrusrOMC0Uq+6eP9HSnfitzeXhWgPD246
         pHmiH6WAwKeMCgzz3dWENYGUsnMzUhrKIxqZVgmksV+v6/vGSvPMjND1rHIJuWvq1C
         DsZ2FQ85x2+5hmWT9F8DprDOVPagPZYonpQLHBYrRyZc9HhfBVqvLaN2UNQxGjy98V
         IsXzUxIGkVhTOSYr+HpNr+QNBCaisrNVcr+CgWl0i/9JQ6NXsgfcD/jOwEzNiPpgQM
         aj4RI19fkDei7FAu95ivPafshOMbaXEeuoVPBGOg4JX0GGx4XHpHjazJ/b/C4Ewr4X
         ZWYVubsAuUVrw==
Date:   Thu, 6 Jan 2022 14:02:05 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexhenrie24@gmail.com,
        bberg@redhat.com
Subject: Re: [PATCH 0/1] Magic Keyboard 2021 with fingerprint reader FN key
 mapping
In-Reply-To: <20220102175113.174642-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2201061401420.16505@cbobk.fhfr.pm>
References: <20220102175113.174642-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2022, José Expósito wrote:

> Hi all,
> 
> This patch is meant to be applied after [1] and [2].

Applied, together with Benjamin's original 2021 keyboard mappings.

-- 
Jiri Kosina
SUSE Labs

