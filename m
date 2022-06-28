Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0B55EDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiF1TPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiF1TPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:15:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00193
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:15:27 -0700 (PDT)
Received: from localhost ([78.43.200.244]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8Qme-1o1qpx440W-004W7g for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022
 21:15:26 +0200
Date:   Tue, 28 Jun 2022 21:15:24 +0200
From:   linux@moellendorf.eu
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Is it possible to backup and restore a configfs subsystem in
 userspace?
Message-ID: <YrtTTCvsVKP94gxa@lars-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/2.2.3 (2022-04-12)
X-Provags-ID: V03:K1:AjtnOIaJPC+HiCEksbdtZ2PnwOcrh5JYIG9OVzgPss64xKV9c/h
 dz9UXgO0Q/HbqMymRrZ6D9LaYqLs5CY+2bj9dR8JtYaayfhvhrm4CYKXazlKqF0t0TtV9y6
 qg21F6Ceoy8GBHdwM1AuXBmlZPfx8qt9hQz5RBXi1bv+FOFZ9i31b4QID9j+bhCJC1Nd9w9
 N3R7W6+5fmaN7K5lBpD4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rPnTzTNCVos=:YKtRNMB/eOlF8PKnpR//eh
 uFm2m0aVdPscD0zyniiZ7nU/xUsy6EMFFP+/VyX6vQnDOJ7LjrdKphh6uLKnKFRPYsujRkPNj
 gwqA07YVpp0n/xJ6nPG4xw/gStnp/o0k1GG7uKSjNRXXpQvQRAAR7qwarJFDBQrd97CBocGmW
 AG94zh83SGd7+D58VI4AD9rT0qJBiVKRLA4Z741THJVie6p16DVj177KPqt+cHVtp6HldPnNY
 qLbX9xTa9Kkdz1jQR1zPiU2CCS+Vej9WJ/+xuWSyin+VO6DYmhcAL1NC9+E1AYgcMG6OIbY7O
 hvXFOo2NvZzkE5iH7YQLEeYX24pAibMKJ/dEO6TSSFROCWltsBicJKSLw91xOu5YyvSzp9ENd
 HyIdmtFRmF0EFgrdvrRsBp9+/J9zS7RXRv0/1cQ1bz32conemSFFB4LmN3SF/AbYGiO9HjsGe
 p+pGct8139EXBgsvdLegCL2FOC2QpybvUeVDxkMS8EFwu4GMlcovfmLeM5GRcMIljCxvpSY9c
 ZrtBpOSeHSdFNBFPbMLwiMX8PxGXh1JRfoDNQUixmDEaJK656eZ06+8rYaC2sPDSEZQdJcyz1
 1Ytdj8IopEQ7EHL2Hkn45Agp4HnFMJ85zHmqGbGZBTNDkTbb8M+PBB0DCEZnuCddDZPE4PYW8
 udi+FwDAvkWcZmLfD2yiH1rJb3njvl7npwyi8IpYkA9cvo0UGSe1UQPmUnAibIrIAS2SkeDuz
 UvlsCjeWE7eO3xfz/SWj8Myvayc+voaYSNW4LZfx4hmwz14SMrIJCVCdl9I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I create a configfs subsystem with some items and attributes in
there, is it possible to backup and restore them in user space?

My first experiments say no:

- rsync: read errors mapping "/sys/kernel/config/my/item": No data
  available
- tar: short read
- cp: skipping file '/sys/kernel/config/my/item', as it was replaced
  while being copied

But maybe I miss something here?

Cheers!
Lars
