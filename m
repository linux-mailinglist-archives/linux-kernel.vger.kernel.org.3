Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240FD577FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbiGRKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRKmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:42:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ECB1EAF6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:42:21 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-046-114-210-034.46.114.pool.telefonica.de [46.114.210.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2EFC1EC0543;
        Mon, 18 Jul 2022 12:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658140936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnLolz37Wt9cnd86wdrrPpITrIWs5UWa0DAzq5TLYB8=;
        b=JYXZ1YGFC/mnTnigyHyYdWfxOn79hr/95Gepm3Y9giviUbfuYNQtDT4TLhzwIpdgHQeFpd
        0FYevJB/QesfewR0XnSN5gNtwZ4SiORrhRhF0J/wJvKRb1jQfG8bGXBgp8CtSPsBg7pySJ
        0J5ZpqIfto6wC16R1Adc0um5CZoY2kQ=
Date:   Mon, 18 Jul 2022 10:42:13 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org
CC:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        dave.hansen@linux.intel.com, nikunj@amd.com, hpa@zytor.com,
        Abraham.Shaju@amd.com
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_FIX_PATCH=5D_x86/e820=3A_Stop_kernel?= =?US-ASCII?Q?_boot_when_RAM_resource_reservation_fails?=
In-Reply-To: <20220718085815.1943-1-bharata@amd.com>
References: <20220718085815.1943-1-bharata@amd.com>
Message-ID: <E7A3FF43-C49F-415E-81C6-CD14F4107349@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 18, 2022 8:58:15 AM UTC, Bharata B Rao <bharata@amd=2Ecom> wrote:
>Currently it is possible to start a guest with memory that
>is beyond the addressable range of CPU=2E This can typically
>be done by using QEMU without explicilty specifying the max
>physical addressable bits (via phys-bits or host-phys-bits
>options)=2E In such cases QEMU will start the guest with more
>than 1TB memory but would implicitly limit the phys-bits to 40=2E

Why does the upstream kernel care about some weird qemu guest configuratio=
ns?=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
