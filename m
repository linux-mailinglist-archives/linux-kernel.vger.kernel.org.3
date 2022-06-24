Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB8559CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiFXOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiFXOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:49:18 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165BF81A10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:44:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k15so2910992iok.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=l9AyWH5dUXc9VfLxh9TSFmwBAk0sP5BF5RMNQJrS+GQ=;
        b=NUcpgBpcF36VbOGUS1YV2k5kVjagmhvmZsZX2BDnVmHAS4AFH+0T+VuZ6ewW6Lq3VJ
         +XuYpCbBfCDuDONbUo4fKFdfxM9hWbNU7vODkO6OxYjMYqsMrEm/x0AXzaYmA963mV+M
         UdVPj23gfbA1zaF3YFD0zzd8IDhdQVQUjL3a+6rzE6uoSOC+VpYt+/REH5qtC2MgWxhO
         DPXkGLC3M5v8U7ip+9a83kF5gI+KdQsFkYUxg/5VDarQnAXmStSHp8Ebw+otHg5N/yMy
         R3qFUq89n4g+/aOaV+Sj8T2IN/uw2IO4ZLQ8kRfK521GyEbxDv9dkBi95TuIT8rLp171
         tD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=l9AyWH5dUXc9VfLxh9TSFmwBAk0sP5BF5RMNQJrS+GQ=;
        b=DPpon4kpAlrbpZTk+KP79pTAQhMJyaeytyU55uWwnVDMN3rJ6AsvYbcIERQuDzdnJa
         kn+Y8zR8pzQeh1PTuks7LdBv5oz5CaDuuO7vl4ilzBCak6ezLheurxpI8cYLUixTZXIK
         emBpXYo7GvUTKivDKLvoJMsck/XpEHjv5DxFCOCfvRaKQKOpk3orK2NPTlWYW09b4lRK
         tXDdVGQafiOp5HbGl3lfpM7cVlV126whLhuRXi4O1abcug8G2d/eNx7rLTUxDxLCcBLr
         XtnidRT9n6Zdvt+cFktEXWSOkRCxF5cNlH0of1kmbpAu60gyLn+lXmVMEHvbJyo028hB
         VrVQ==
X-Gm-Message-State: AJIora8S25GzLYIojm0uvnEUW6MCEyPuqElmpB63yzJZNNKHCdJoHSsT
        1iRP3HKAi/ptosZLurljaZ72DiVAt2Y/PQUiIPI=
X-Google-Smtp-Source: AGRyM1tJUGmTCTefR3roS3zpgrafDQnBMuaL9GJrDzPV9lhk36gyAQG4+hcufjOifr9OQ47EUcNOJRw7al4lInZchCE=
X-Received: by 2002:a02:94a2:0:b0:339:e395:764c with SMTP id
 x31-20020a0294a2000000b00339e395764cmr6704382jah.230.1656081887142; Fri, 24
 Jun 2022 07:44:47 -0700 (PDT)
MIME-Version: 1.0
Sender: noelinekasse@gmail.com
Received: by 2002:a02:900c:0:0:0:0:0 with HTTP; Fri, 24 Jun 2022 07:44:46
 -0700 (PDT)
From:   Orlando Moris <kelvinedmond612@gmail.com>
Date:   Fri, 24 Jun 2022 14:44:46 +0000
X-Google-Sender-Auth: x--RhJGUvU0SAIcHgM9YJJqEeoY
Message-ID: <CALZWmmwa_-BS7joKjO5_AVN4q+c69w7sFF3YE9nKT1WaTiELDw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Houd er rekening mee dat deze e-mail die in uw mailbox is
binnengekomen geen fout is, maar specifiek aan u is geadresseerd voor
uw vriendelijke overweging. Ik heb een voorstel van ($ 7.500.000,00)
achtergelaten door mijn overleden klant ingenieur Carlos, die werkte
en leefde hier in (Lome Togo) voor zijn dood in een ongelukkig
auto-ongeluk met zijn familie, neem ik contact met u op als
nabestaanden van hem, zodat u het geld bij claims kunt ontvangen. op
uw snelle reactie zal ik u informeren over de modi van
uitvoering van dit verbond, neem contact met mij op via deze e-mails
(orlandomoris56@gmail.com)
