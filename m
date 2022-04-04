Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC244F1703
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377368AbiDDOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377461AbiDDOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:32:08 -0400
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 07:30:04 PDT
Received: from antispam.asistech.com.mx (antispam.asistech.com.mx [74.208.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9170823BD9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:30:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by antispam.asistech.com.mx (Postfix) with ESMTP id 64BB836643C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:20:34 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asistech.com.mx;
         h=content-type:content-type:mime-version:message-id:reply-to
        :from:from:date:date:subject:subject:received:received:received;
         s=dkim; t=1649082034; x=1650896435; bh=2ZNqXj+9qnM+UamLvM7VEZuP
        E8PN3B4GPPdQn1KCDCw=; b=WrdXE4A5ZbmmfpFeGgNk6VBqO+GZnekNcxOzM9sD
        oN9E5MotSgn/u0KGfiVcvIUQQMJVWDavjx3xYGxUPXyQY2/IP6YeYDL7AK8UQ1j9
        HnxwVUnVMvjoHYINzAIC3Qpcd4X66Hd3veYZODKuaGDDu7q4GlYUgY3w/qcc+5fZ
        tA4=
X-Virus-Scanned: Asistech-antispam amavisd-new at asistech.com.mx
Received: from antispam.asistech.com.mx ([127.0.0.1])
        by localhost (antispam.asistech.com.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4f4Va-9ja_t8 for <linux-kernel@vger.kernel.org>;
        Mon,  4 Apr 2022 09:20:34 -0500 (CDT)
Received: from ubuntuprod (unknown [192.168.100.160])
        by antispam.asistech.com.mx (Postfix) with ESMTP id 6EB4D366444
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:20:11 -0500 (CDT)
Received: by ubuntuprod (Postfix, from userid 33)
        id 1D8ED1069A4; Mon,  4 Apr 2022 09:15:53 -0500 (CDT)
To:     linux-kernel@vger.kernel.org
Subject: Intermediary needed (urgent)
X-PHP-Originating-Script: 33:fqgniqgire.php(1) : eval()'d code(1) : eval()'d code(286) : eval()'d code(1) : eval()'d code
Date:   Mon, 4 Apr 2022 09:15:53 -0500
From:   Andrei Sergeinovich <support@asistech.com.mx>
Reply-To: llgaztechmoscow@yandex.ru
Message-ID: <f48d44ea110c059b50e479d6fc5d079e@www.asistech.com.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        PDS_PHP_EVAL,PHP_ORIG_SCRIPT_EVAL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5767]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.5 PDS_PHP_EVAL PHP header shows eval'd code
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 PHP_ORIG_SCRIPT_EVAL From suspicious PHP source
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can you help me claim a huge amount of money in Russia? It's urgent.

Regards,
Andrei.

