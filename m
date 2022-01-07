Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E73486FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 02:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbiAGB7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 20:59:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48452 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbiAGB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 20:59:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E583E61D99;
        Fri,  7 Jan 2022 01:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F0C36AE0;
        Fri,  7 Jan 2022 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641520757;
        bh=Cg2WtUWzGyxz0klG28rSrT62O/0I9SzR33Xw+ocpgkc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a6HkxRC7hihMMFBSeeN46MbqdHY1yx/+glr4xT6ai7CZO6j7C0Ed1S8uBlRF24yp1
         fyU0jXIMI+NWWLMhIan+5ApJrhqOuDMEz+jfytlR5BA54owxEp9zfrq76gUN/Gt72t
         NMuGYksdEncNGzxTU8I3pPTbPt8hQt/oqu5lCEC6hi26CvrGW/M792qv1wWzmNgHYu
         B8eiN8pQ7AWBhhKADJnlwVNw6ALndC7XeYbmj1OWCgx7oG7zFH7/TCKLO79OkoTfyZ
         QQghZJ5BmgBQVos9xBYCtXeLB0mLqo7lN/+BJ6TBYRi5C2kaPBeHofYrJ6dC/6m4SH
         Fr9VpJpl4elsQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211212180527.1641362-5-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com> <20211212180527.1641362-5-AjitKumar.Pandey@amd.com>
Subject: Re: [PATCH v5 4/5] clk: x86: Use dynamic con_id string during clk registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Vijendar.Mukunda@amd.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 06 Jan 2022 17:59:16 -0800
User-Agent: alot/0.9.1
Message-Id: <20220107015917.480F0C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ajit Kumar Pandey (2021-12-12 10:05:26)
> Replace hard coded con_id string with fch_data->name. We have clk
> consumers looking up with different clock names, hence use dynamic
> con_id string during clk lookup registration. fch_data->name will
> be initialized in acpi driver based on fmw property value.
>=20
> Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
> ---

Applied to clk-next
