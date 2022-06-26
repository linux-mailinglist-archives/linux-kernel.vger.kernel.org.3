Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AB855B383
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiFZS3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiFZS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:29:43 -0400
X-Greylist: delayed 32205 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Jun 2022 11:29:42 PDT
Received: from mailgw01.garantiserver.com (mailgw01.dnsflare.com [185.85.206.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BDBDFEA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:29:42 -0700 (PDT)
Received: from 204139.dnsflare.com ([185.85.204.139]:34508)
        by mailgw01.garantiserver.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <greyson.edwardchevron@gmail.com>)
        id 1o5Ocf-0007M0-36
        for linux-kernel@vger.kernel.org; Sun, 26 Jun 2022 12:32:06 +0300
Received: from 204139.dnsflare.com (localhost [127.0.0.1])
        by 204139.dnsflare.com (Postfix) with ESMTP id D02B820E632B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:32:05 +0300 (+03)
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000,
        BODYTEXTP_SIZE_400_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
        BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_300_399 0.000000,
        BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
        CTE_QUOTED_PRINTABLE 0.000000, DKIM_SIGNATURE 0.000000,
        FORGED_FROM_GMAIL 0.100000, FRAUD_HIGH_X3 0.000000,
        FROM_NAME_PHRASE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
        IN_REP_TO 0.000000, MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000,
        NO_URI_HTTPS 0.000000, REFERENCES 0.000000, REPLYTO_FROM_DIFF_ADDY 0.100000,
        TO_UNDISCLOSED_RECIPIENTS 0.000000, WEBMAIL_SOURCE 0.000000,
        WEBMAIL_USER_AGENT 0.000000, __ANY_URI 0.000000,
        __AUTH_RES_DKIM_PASS 0.000000, __BODY_NO_MAILTO 0.000000, __CT 0.000000,
        __CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DC_PHRASE 0.000000,
        __FRAUD_INTRO 0.000000, __FRAUD_JOB 0.000000, __FRAUD_PARTNERSHIP 0.000000,
        __FRAUD_SUBJ_ALLCAPS 0.000000, __FRAUD_WEBMAIL 0.000000,
        __FRAUD_WEBMAIL_FROM 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
        __FROM_GMAIL 0.000000, __FROM_NAME_NOT_IN_BODY 0.000000,
        __FUR_HEADER 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
        __HAS_REFERENCES 0.000000, __HAS_REPLYTO 0.000000, __INT_PROD_LOC 0.000000,
        __IN_REP_TO 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
        __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000, __MSGID_32HEX 0.000000,
        __NO_HTML_TAG_RAW 0.000000, __PHISH_SPEAR_GREETING 0.000000,
        __PHISH_SPEAR_STRUCTURE_1 0.000000, __PHISH_SPEAR_STRUCTURE_2 0.000000,
        __REFERENCES 0.000000, __RUS_SUBJ_ALL_UCASE_1251 0.000000,
        __RUS_SUBJ_ALL_UCASE_KOI8R 0.000000, __SANE_MSGID 0.000000,
        __SUBJECT_ALLCAPS 0.000000, __SUBJECT_NOLC 0.000000,
        __TO_MALFORMED_3 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
        __URI_NS 0.000000, __USER_AGENT 0.000000,
        __USER_AGENT_ROUNDCUBE_WEBMAIL 0.000000
X-SASI-Probability: 9%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 4.1.4, AntispamData: 2022.6.26.84819
Authentication-Results: 204139.dnsflare.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=ornekdomain.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ornekdomain.com;
         h=content-transfer-encoding:user-agent:message-id:references
        :in-reply-to:reply-to:subject:subject:to:from:from:date:date
        :content-type:content-type:mime-version; s=dkim; t=1656235925;
         x=1658827926; bh=lsDT4tvAc3Bj211wDsf28O2PMftqo7mPcbgISGd07Jw=; b=
        c2Vgkw1XH1vPnCPSYW9jgNlMr04DmW8LQVp7yffXdypamFI1uZ+O5jH1ONhZlyin
        37S6Bgjf7lA35NDVIxz5PohKzTaJ4KwUmfiwQgzrVKbQviTmv2xoMYhugb2wG4oi
        uQZ7XFMioPJqfsn41pXzZXQHnYqix2/VsfoOxpiXvdE=
X-Virus-Scanned: Debian amavisd-new at dione.dnsflare.com
Received: from 204139.dnsflare.com ([127.0.0.1])
        by 204139.dnsflare.com (204139.dnsflare.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EarPSROzrHRZ for <linux-kernel@vger.kernel.org>;
        Sun, 26 Jun 2022 12:32:05 +0300 (+03)
Received: from _ (localhost [127.0.0.1])
        by 204139.dnsflare.com (Postfix) with ESMTPSA id CD42E20E6336;
        Sun, 26 Jun 2022 12:30:32 +0300 (+03)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date:   Sun, 26 Jun 2022 10:30:32 +0100
From:   "Chevron HR, Employment" <greyson.edwardchevron@gmail.com>
To:     undisclosed-recipients:;
Subject: FOREIGN JOB OPENING!
Reply-To: greyson@chevron-hr.com
Mail-Reply-To: greyson@chevron-hr.com
In-Reply-To: <86406f7382d3cbe4949e7fc7763e1a9f@outlook.com>
References: <86406f7382d3cbe4949e7fc7763e1a9f@outlook.com>
Message-ID: <3ba1a9245d7d756a5473be6043e9ea91@gmail.com>
X-Sender: greyson.edwardchevron@gmail.com
User-Agent: Roundcube Webmail
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
        KHOP_HELO_FCRDNS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATTN,

      This is to inform you that we are currently hiring foreign=20
international reputable and experienced applicants on various job=20
positions available if you are interested kindly apply by sending your=20
CV/r=C3=A9sum=C3=A9 to greyson@chevron-hr.com for more details.

Regards
Greyson Edwards
EMEA Recruitment Team Lead.
HR Chevron Corporation London UK
