Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9B59A5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350913AbiHSS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350111AbiHSS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:57:12 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB3FEE92;
        Fri, 19 Aug 2022 11:57:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0B31F3B7A74;
        Fri, 19 Aug 2022 14:57:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3lZMkGODt-IH; Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 874613B78F5;
        Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 874613B78F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1660935429;
        bh=6rmtj4UFHePqWJceVQhRqpzznhW6LnpT2VRjtwGS2TA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vRnfSePuLRdGSlWXFTbKnecqhWw30sGY2up/Lrcj4v2bt/ENJd5zvtypXLrJo1hsc
         BGpB9jqhz1K0TwjpOaB3cURChp/ZcKQNYoLbFFhb5H3/LvPLEtCR0vMSAaaMwunfTw
         GDf3fdgaMdXz1KpThKEaTAlGp3taFmQW+wm/ZP6KNHX/uT7dxWx8llBpKQztNzDhIK
         61E8p+NwriNfP4FB7Blk2Qnevgq8uwkZSOlGGv79y/Lx94EAN871SvFnyNbrVWL8eg
         T6ZlqbuuzU9ymAlQseYZxZkoiTcujtyS6qCHeRWNzA+D+NItg+ObIL91G58f5DXkaq
         hgTAdUK72GhDg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fiECbDsY4bAE; Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7961A3B7FA6;
        Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
Date:   Fri, 19 Aug 2022 14:57:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        lwn <lwn@lwn.net>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1273091514.17599.1660935429453.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.10 and 2.13.5 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - FF103 (Linux)/8.8.15_GA_4372)
Thread-Index: njpMKIkDnXU7Voqt9NfXwqumSfFwyQ==
Thread-Topic: LTTng-modules 2.12.10 and 2.13.5 (Linux kernel tracer)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a release announcement for the two currently maintained stable branches
of the LTTng kernel tracer.

* New in these releases:

Version 2.12.10 and 2.13.5 fix tracepoint instrumentation to support stable kernels in the
version range v5.15.58 to 5.16. They also fix incorrect stub prototypes for
CONFIG_HAVE_SYSCALL_TRACEPOINTS=n. A minor fix to tie compaction probe build to
CONFIG_COMPACTION has also been added.

Version 2.13.5 updates the tracepoint instrumentation to support Linux kernel
v5.19, and v6.0-rc1.

Feedback is welcome,

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
