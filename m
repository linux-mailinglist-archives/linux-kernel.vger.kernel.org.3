Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E24BBED1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiBRR5k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 12:57:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiBRR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:57:38 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188431023
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:57:20 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-_ZKSJtigOeKV0yPjvx4iCg-1; Fri, 18 Feb 2022 12:57:16 -0500
X-MC-Unique: _ZKSJtigOeKV0yPjvx4iCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4DA1801AC5;
        Fri, 18 Feb 2022 17:57:14 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2342C2BCC1;
        Fri, 18 Feb 2022 17:57:12 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 0/3] rtla: Some RTLA fixes for 5.17
Date:   Fri, 18 Feb 2022 18:57:06 +0100
Message-Id: <cover.1645206561.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These is a set of fixes for RTLA on 5.17, the commit logs explain more
details about them.

Daniel Bristot de Oliveira (3):
  rtla/hist: Make -E the short version of --entries
  rtla/osnoise: Free params at the exit
  rtla/osnoise: Fix error message when failing to enable trace instance

 Documentation/tools/rtla/common_hist_options.rst |  2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst   |  2 +-
 tools/tracing/rtla/src/osnoise.c                 |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c            | 10 +++++-----
 tools/tracing/rtla/src/osnoise_top.c             |  1 +
 tools/tracing/rtla/src/timerlat_hist.c           | 10 +++++-----
 6 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.34.1

