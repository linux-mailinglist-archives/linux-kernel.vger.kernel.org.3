Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B6515F7C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiD3RRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiD3RRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:17:43 -0400
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [221.12.31.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B64EDEC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:14:20 -0700 (PDT)
Received: from mail.maildlp.com ([172.25.15.154])
        by h3cspam02-ex.h3c.com with ESMTP id 23UHDk5b085179;
        Sun, 1 May 2022 01:13:46 +0800 (GMT-8)
        (envelope-from zushuzhi@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (unknown [10.8.0.73])
        by mail.maildlp.com (Postfix) with ESMTP id 5A6392221BC2;
        Sun,  1 May 2022 01:15:59 +0800 (CST)
Received: from DAG2EX04-BASE.srv.huawei-3com.com (10.8.0.67) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 1 May 2022 01:13:51 +0800
Received: from DAG2EX04-BASE.srv.huawei-3com.com ([fe80::e428:b7f:b838:6159])
 by DAG2EX04-BASE.srv.huawei-3com.com ([fe80::e428:b7f:b838:6159%2]) with mapi
 id 15.01.2375.017; Sun, 1 May 2022 01:13:51 +0800
From:   Zushuzhi <zushuzhi@h3c.com>
To:     "brauner@kernel.org" <brauner@kernel.org>
CC:     "oleg@redhat.com" <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zushuzhi <zushuzhi@h3c.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSBzaWduYWwvcHRyYWNlOiBGaXggdGhlIHByb2JsZW0g?=
 =?gb2312?Q?of_ptrace_attach_and_signal_handling_oncurrency?=
Thread-Topic: [PATCH] signal/ptrace: Fix the problem of ptrace attach and
 signal handling oncurrency
Thread-Index: AQHYXLWpqWqZIuTJM0OSIH69+snbdg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 33
X-FaxNumberOfPages: 0
Date:   Sat, 30 Apr 2022 17:13:50 +0000
Message-ID: <90b5c5ad95d54530baac1b08549bafc4@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.114.76.218]
x-sender-location: DAG2
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 23UHDk5b085179
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enVzaHV6aGkgKFJEKSC9q7O3u9jTyrz+obBbUEFUQ0hdIHNpZ25hbC9wdHJhY2U6IEZpeCB0aGUg
cHJvYmxlbSBvZiBwdHJhY2UgYXR0YWNoIGFuZCBzaWduYWwgaGFuZGxpbmcgb25jdXJyZW5jeaGx
oaM=
