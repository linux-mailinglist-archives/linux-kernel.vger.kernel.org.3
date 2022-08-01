Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80589587156
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiHATWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiHATWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:22:39 -0400
X-Greylist: delayed 8564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 12:22:36 PDT
Received: from host.olayscemailers.biz (olayscemailers.biz [92.63.169.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38B8A3892
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:22:36 -0700 (PDT)
Received: from olayscemailers.biz (unknown [113.30.188.128])
        by host.olayscemailers.biz (Postfix) with ESMTPA id 3B7B5103D7D1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:17:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.olayscemailers.biz 3B7B5103D7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=olayscemailers.biz;
        s=default; t=1659370662;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Subject:Date:From;
        b=C0dQFJyq4eaDjWSx6oG0x1hQ6xLSHtngJpRNobZmrfdLqcig8lM4gibcMGpmTkCrt
         0bdItcRcjX4/kEOYU0dHoRwGDeITm+pL8KXFiKWHXVOsB+3TaXNFHFOdN+iBxFfhb5
         cTuz+D13hBy4iwZfttIVg1w7H5/665zBH+B4Rv2o=
DKIM-Filter: OpenDKIM Filter v2.11.0 host.olayscemailers.biz 3B7B5103D7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=olayscemailers.biz;
        s=default; t=1659370662;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Subject:Date:From;
        b=C0dQFJyq4eaDjWSx6oG0x1hQ6xLSHtngJpRNobZmrfdLqcig8lM4gibcMGpmTkCrt
         0bdItcRcjX4/kEOYU0dHoRwGDeITm+pL8KXFiKWHXVOsB+3TaXNFHFOdN+iBxFfhb5
         cTuz+D13hBy4iwZfttIVg1w7H5/665zBH+B4Rv2o=
Reply-To: christospav209@secservermails.biz
From:   C Pavlides <christospav209@olayscemailers.biz>
To:     linux-kernel@vger.kernel.org
Subject: Collaboration
Date:   01 Aug 2022 19:17:42 +0300
Message-ID: <20220801191741.4BB93FA86499750B@olayscemailers.biz>
Mime-Version: 1.0
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: olayscemailers.biz]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.6 DATE_IN_PAST_03_06 Date: is 3 to 6 hours before Received: date
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 TVD_SPACE_RATIO No description available.
        *  1.0 FROM_FMBLA_NEWDOM From domain was registered in last 7 days
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

