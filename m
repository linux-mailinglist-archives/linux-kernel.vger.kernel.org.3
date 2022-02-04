Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA824A9D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbiBDQqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:46:20 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:33480 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiBDQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:46:19 -0500
Received: by mail-yb1-f175.google.com with SMTP id j2so20656353ybu.0;
        Fri, 04 Feb 2022 08:46:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BvSuNBp8dR/Kb3EjKCpYDsXctSQVZqQDAcffA+q3los=;
        b=7D3z2vm0h1j4atOFoOENz9bLXdyzCLlLpc4+nItU5ZeuGiKPdm7eQvK4nveCccMAiU
         LyvnrQZ5poZ9PTbMl/482N9gywqddiQeyDkLM4CAu5vrYrclL9PMftwG2srms5iEL1lv
         Ka8f7prpywo6ueQAFPOrGTJgYJzUHmqxfPqfRBGdyaDrCnQH7I02PcZnf2TtjKXaJvGT
         9ZtO2rKAUHwSYVVPOoHjoYLl4JSZXMuxaFDqry6cKWaAoySzfMhXHL091a5jTLfpmSol
         +aPQexsMK2R+qzJkYRpYUVKRR9x5GLu/z95tGBzet77Ksn0wCPIiHuOAMG4o+Yskzmlj
         vwqg==
X-Gm-Message-State: AOAM533IDqNVjmbshorGyKWsazXW+Gu93WWsXRWbxvx2Cgjiqcc+PrPg
        Fr+gUA8acizuJ+wJjj/CVj/sh6oQinI4NWa7G9bu1wxv7jU=
X-Google-Smtp-Source: ABdhPJyAFVEJdp1U9YTbB71BrJTCw0XHR3u847HkemF7OS0ij0YeJcjoDQH8HyWf0BmGEBijaLROnZtx3zl9ycbUSU4=
X-Received: by 2002:a05:690c:118:: with SMTP id bd24mr3969605ywb.515.1643993178854;
 Fri, 04 Feb 2022 08:46:18 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 17:46:08 +0100
Message-ID: <CAJZ5v0h9f770hRMXazt4jk=9E01hMjQ41pZ5+Ym-4p0dCrhwmw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.17-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.17-rc3

with top-most commit 04662bac0067e2fd7f243d6abaa4d779bce14114

 ACPI: require CRC32 to build

on top of commit 26291c54e111ff6ba87a164d85d4a4e134b7315c

 Linux 5.17-rc2

to receive an ACPI fix for 5.17-rc3.

This fixes compilation in the case when ACPI is selected and CRC32,
depended on by ACPI after recent changes, is not (Randy Dunlap).

Thanks!


---------------

Randy Dunlap (1):
      ACPI: require CRC32 to build

---------------

 drivers/acpi/Kconfig | 1 +
 1 file changed, 1 insertion(+)
