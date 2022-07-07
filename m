Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CFC569752
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiGGBSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiGGBS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:18:28 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A03AC59;
        Wed,  6 Jul 2022 18:18:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 61C561E80D82;
        Thu,  7 Jul 2022 09:16:05 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ryWmeIElm7AS; Thu,  7 Jul 2022 09:16:02 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9965B1E80D74;
        Thu,  7 Jul 2022 09:16:02 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     rafael@kernel.org
Cc:     kernel@nfschina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zeming@nfschina.com
Subject: Re: [PATCH] acpi/sbshc: Add header file macro definition
Date:   Thu,  7 Jul 2022 09:17:57 +0800
Message-Id: <20220707011758.3082-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <CAJZ5v0i4vuH7V-8UUESTOaC5MKuKycLUeC+MsR-Mwq-KE8-d9w@mail.gmail.com>
References: <CAJZ5v0i4vuH7V-8UUESTOaC5MKuKycLUeC+MsR-Mwq-KE8-d9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I think the header file could avoid redefinition errors.
 at compile time by adding macro definitions.

