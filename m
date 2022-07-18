Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27446577D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiGRIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:30:38 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8889318B3A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:30:37 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id t21so4957396uaq.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1s+lxhOMqq4O56VoMuk2kFee42cpuqF01E2Fde/OMmU=;
        b=LeHRciFnIn1BVUUFvOLDuMBYvXLraHZmnabK8QTCJP8Qr6xSRw8Vyad4Ok0v/3F8zh
         Co2D0noZ2rAMohJDMZzd3KSWCPmBjpRkdUfT0CRzPQ6ggfO6rNdU9Yv0K5CdfRIkmGGj
         V+6po2q8v+GDBgqTdPoUr83Pd0cM5TF2WQQmHVfdRJ3e4dh2xMPr/Ah/qC+HzQFvBzsD
         kuFVVSBF6e8ypKth9C9IO5kot+l783w3ixIc3a4kMxeAvWYXJpdSlwBQmG7ywQz2Ui8D
         xzGWaeJyBARq/3X5xddDoiAEHFihj8F2GAYzd/vvlR9x/5ML+wmYmfpNEBElA3ehC+br
         d0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1s+lxhOMqq4O56VoMuk2kFee42cpuqF01E2Fde/OMmU=;
        b=QawJgHgCozV83b8SLnDbLi90s1L7kw5mdhOzbmKg8tYzTn99sn4/vf+Gq5MjmhPrCK
         X89gM1LOrPzLKPB/8GMttCWjDdo/7gFWA7X8KgeAms831r0Om2U05du5T+RPCW6pZUZw
         xs20ed9f5ipDscQyPZWEG4gZdGzZjoPNre9lUS3agJNTxNqBvyaul0BWeInSDARSbMNC
         f3hgT0uzTXZcpKXLQSfykEbOAfGoucO6+rXNbEdpP+MS7XsPOcm3xCzRP+hjuXCRxi2B
         UheGDR09w6bdM8hZt0OdG/wTaufBancgXZYqIqtXswZfXqVBCzgTpr1LJ2billxq27I5
         40nQ==
X-Gm-Message-State: AJIora805SdccWFwRNPlr0upApEqfxLw+sqSqfwbft/zEp1GclLU7y2L
        W4/d4uluqscb2mx65Yuoq842CSWsptsgCLW9n7I=
X-Google-Smtp-Source: AGRyM1uniMWeVea2RC7S0lhQkuAmfXLtdJYD/sktVvSvoiorBSjS4+17LjOQTBIES16QbwzNzMimG8RIUo2Q9Xfx6IA=
X-Received: by 2002:ab0:6d9a:0:b0:383:7010:8a5f with SMTP id
 m26-20020ab06d9a000000b0038370108a5fmr9307698uah.20.1658133036499; Mon, 18
 Jul 2022 01:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:1682:b0:2d1:82a4:fc30 with HTTP; Mon, 18 Jul 2022
 01:30:36 -0700 (PDT)
Reply-To: lmarwane.sacemm@gmail.com
From:   ENGEL CZ sro <rpkoliv@gmail.com>
Date:   Mon, 18 Jul 2022 10:30:36 +0200
Message-ID: <CAOqzm5z0800TgRV=vbwBmncm9nCq0bwsv6=Dgk9RDK3MVnpdTQ@mail.gmail.com>
Subject: Inquiry
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Seller,

Greetings to you and your esteemed Company.

My name is Mr Marwane Lofti Marketing Director of  ENGEL  CZ  sro. I
would like to inquire about your products.
After going through your website, we have to state that we are
interested to make a purchase from your esteemed company.

* Is your Company manufacturer and supplier?
* Have you exported to the Czech Market ?. If this is correct, could
you please inform us how many days it takes to deliver the goods to us
in Czech Republic?
* Do you have Company Profile and Product Catalog? Please send us for
our review to enable us proceed

I await to receive answers from you by return mail soon

Thank You,
Mr Marwane Lofti
ENGEL  CZ  sro
Baarova 305/18
150 00 Prague 4
Czech Republic
