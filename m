Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FEF5861FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 01:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiGaXkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 19:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiGaXkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 19:40:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1203BCB1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:40:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so4838526wmm.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=IniFjyVHQ6lWflzIsICmJ5JUtVB9MkE1WWkHF07cmBg=;
        b=GbH6WS/PJ77Yxq1SFpTHzUn9b4A6DJyqFvexLdNvw9q/5uay9W+18FY3DrA3cnSIIb
         pYM/4+XvU1aV1jLG0xh/sDb3WZY1rl5Msy3nXYJzpAIx9TL0Dk+rhRIn9WpZ2HEQ52Qv
         92tksA3ZA1JyKPHK00SG0HmjbEnV7KJ7mAJF6a4zWlqjQ2REPE7bNfO/yZaVzKE4c7g9
         hgbJIfH6UvtxjaITLnnxFiO4XX4xyeIBYKjcJCR10J1VNWwyRTpADZ7LcJCbzYwOU5Bi
         OHdcGmtm/dJ54oSqXD5F+DS/vkDQSYtX24jOaayfVXzCrUkn0wwl1bwlzb2TmGMZ6mv7
         jjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=IniFjyVHQ6lWflzIsICmJ5JUtVB9MkE1WWkHF07cmBg=;
        b=5WlzaX+S4S+OTcG7Q2yhjHIzezJnOUL66R1I+qPvaKcA3vOeZ4Kojz1ccJAHrpkybq
         FhOsum8CjFqdvaTdmTBinGt6VRDqWaWWTW9U11KOo1k5hwvDOXUL/EWibUj32EwnzDmD
         94+yfhZfPMWa/wNqZXJZ5FFHc+lHhSWniGmMveSPHXw/N7L/ymraAQFmCaWFHdAMKih5
         S5gYeyr0oK8mlh6pyu+aeZoV8iiE8usjWjRkYzSiZ61YlfbkZAXY+Jqxvddxd4XyNOr0
         PLBVIml4TuHI8cMXUDNfj/PHM93rQwdeYGmRq0r8eYVWEzVEBoPI4eFf62zU+rM9hgks
         sMOg==
X-Gm-Message-State: AJIora9Ey/ia2My7qrFUraKBYoWESH/SI6gm1PFYVLEOcCVPFgRJIuu0
        NU+sxCzihrVe95+EG5NmxwXTHAMtNCF67HJUCAY=
X-Google-Smtp-Source: AGRyM1tUL1PtMlYHh6W5KPFcZbApC9b96DH1UmZJNLPiW+c4yfeEmUfeQcZBM2z60acaT8XGUal/Sn/+dLCHvnrK1fs=
X-Received: by 2002:a05:600c:6009:b0:3a3:1506:f60f with SMTP id
 az9-20020a05600c600900b003a31506f60fmr9403719wmb.144.1659310827508; Sun, 31
 Jul 2022 16:40:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6021:905:b0:1f2:7126:830c with HTTP; Sun, 31 Jul 2022
 16:40:26 -0700 (PDT)
Reply-To: usdepartmenttreasury63@gmail.com
From:   "U.S. DEPARTMENT TREASURY" <milleymilley325@gmail.com>
Date:   Sun, 31 Jul 2022 23:40:26 +0000
Message-ID: <CANf+LmtkG9FkKgntNC-fec-4h7O8Bh7Qf-EhNrp2FLuy_0KpJw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:335 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [milleymilley325[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [usdepartmenttreasury63[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [milleymilley325[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

You have an important message get back to me for more information.

Mr. Marcus Hamlin
Deputy U.S. Department of the Treasury
