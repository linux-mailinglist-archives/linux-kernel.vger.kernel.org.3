Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88256FE49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGKKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiGKKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:07:46 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9849BBD35
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:31:29 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a184so4382598vsa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=UyuYhCpeqCpq+XCxjDW15M1VPxXZVypFQSDO+9r7mma7oioaWrbY9OBJ9p7SQmWuTb
         LnO6nk9yoaCLbOMr81M5kQj2Ts4afG6olH5aVzgJlStk2+suhFJPbU76xXVeHJX0ZjUU
         YiZb6jLQSVufG8GtZEEr8tt7qbCW3tqEqe5gwyGTevIVlg+Qlguwh3NVtTvDsmNkng0E
         22Gjq4vKiJAB902zAm6I+V5rFVCZhhARQo5RmVjwp/RvefP8JaVP19D0eZIJCWDKrzxo
         tz21X5TXIswTmGoK/hIE90G7qG5LM6so948nLwv97Bl8U5r+Si2vyn2lMYR1nY2YDiJO
         Q1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=DBXVr+2yQA4Yc+mJwCPapHs1PcqJSd/+SbzdjhsE7eQ=;
        b=a9Rc1Cjia1lbJXCallTIVAuOBOC7BSDnb/H5oGuFq1sRgq7cnfvod8Eg5iEEof5sPF
         JenFt5xYvfLpqEWBzXg3NoSH82iM5kmiZRGE6Iu3OfwaO49BlnI1P5AHQpSXQZb04nxD
         rqhw+0ERGAtU6XEgjlfFgvdDOdaIKqOocz4dzLHvvJ8BrUwgkFdbFevdGEe+23dy8kFN
         TOmeHtGgSqzOWvjpX7bGN1RZIEa3aVDnHvQ7H3oZTRqqvwTSOYGvl7GgkTWEXT2JnjYe
         s5nH0Uu+BHI4+qYNtHNAUclOnRlyQAZlMkJe7rzR/soWO1MZD6ONzCpiJ5empBPfjCuA
         RRTg==
X-Gm-Message-State: AJIora+2xJoGnmQ7VlcpALcvPFLOx/TaHIQJkryqm1gBs+HurtHKMhMl
        ufjoEXKK71V3U6GHJnF3A2p/Y9XFQsqX6jiwLMU=
X-Google-Smtp-Source: AGRyM1vDb8P/DEJhaTm+vB9FeDARvO4SMKH8zf2qaC/rAstu4OQPRmsuF0EgDt4wqEsFRMKoGzMYEz5rzNn96mfDN4A=
X-Received: by 2002:a67:c801:0:b0:357:50cb:1e83 with SMTP id
 u1-20020a67c801000000b0035750cb1e83mr2631854vsk.69.1657531888302; Mon, 11 Jul
 2022 02:31:28 -0700 (PDT)
MIME-Version: 1.0
Sender: myofficeada@gmail.com
Received: by 2002:ab0:a94:0:0:0:0:0 with HTTP; Mon, 11 Jul 2022 02:31:27 -0700 (PDT)
From:   Chevronoil Corporation <corporationchevronoil@gmail.com>
Date:   Mon, 11 Jul 2022 10:31:27 +0100
X-Google-Sender-Auth: zhChCjA2qgIfISzUyC9o_tBWMrM
Message-ID: <CACvfspRjVbo6wbQvgbxP9Aw2yUxMZrJGOBg9=MxkrTmBss3SKA@mail.gmail.com>
Subject: RE U INTERESTED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BEWARE, Real company doesn't ask for money, Chevron Oil and Gas United
States is employing now free flight ticket, if you are interested
reply with your Resume/CV.

Regards,
Mr Jack McDonald.
Chevron Corporation United USA.
