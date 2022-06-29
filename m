Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6B560BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiF2Voe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiF2Vob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:44:31 -0400
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 14:44:29 PDT
Received: from DIEST-MAIL1.Diest.local (mail.diest.be [78.24.171.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60B37A17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:44:29 -0700 (PDT)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
DKIM-Signature: v=1; a=rsa-sha256; d=diest.be; s=20211130; c=relaxed/relaxed;
        t=1656538160; h=from:subject:to:date:message-id;
        bh=FcnLqhMsusH1MbM+yJFHT/lonUwm/+7GT3njOROwhbg=;
        b=RRvkzbe2X+vW1O2cHSqv/Wf6M5dG7O/74iISNnXOq2sDGq68HapSqaT2d/KXpLZEJ+VFDeddG1h
        7LVzo/ldGlzAD8duJN+wYtTyHCgPBThP9f8CQmzRI+dIHOq3v7Ot7U3f6aRI0z7m8LQVDT3f1WjM7
        yTt9eC6NTKNzaubQzgZ/zax5E/o2IYvv2aiQ5v+ERv4Ne9EsLRDeu96xtkE5Yqe5hHySxxhaWkrBs
        2icFARI6Yw74c1yF1ua65wYTw9yxrw89k6/tdAjAJhCmavtEVoSAOmhE/HwJREgPAPV1AcGtVgLj7
        50Qu7iEpS4T7vdeK0ZbWfsq67532MiLGilKw==
Received: from DIEST-MAIL1.Diest.local (10.132.123.7) by
 DIEST-MAIL1.Diest.local (10.132.123.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2375.17; Wed, 29 Jun 2022 23:06:27 +0200
Received: from [2.56.58.93] (2.56.58.93) by DIEST-MAIL1.Diest.local
 (10.132.123.7) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 23:06:27 +0200
MIME-Version: 1.0
Subject: RE
To:     Recipients <hannah.bellens@diest.be>
From:   "Mr. Li Ka-Shing" <hannah.bellens@diest.be>
Date:   Wed, 29 Jun 2022 14:06:25 -0700
Reply-To: <likashinghumanitarianprject306@zohomail.eu>
Message-ID: <0532f838-dbac-4eba-afe4-c4f17b903d0d@DIEST-MAIL1.Diest.local>
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_NAME_MR_MRS,RCVD_IN_SBL_CSS,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [2.56.58.93 listed in zen.spamhaus.org]
        *  1.5 RCVD_IN_SORBS_WEB RBL: SORBS: sender is an abusable web server
        *      [2.56.58.93 listed in dnsbl.sorbs.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  1.0 HK_NAME_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you receive my previous email?
