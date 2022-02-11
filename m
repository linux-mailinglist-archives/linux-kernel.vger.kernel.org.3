Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A44B3122
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351337AbiBKXE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:04:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:04:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F9D53
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 15:04:52 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 200so9570905qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 15:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=r1rcGz3oiI36OObFHrfowwldn52EAu3Sn/GxYj8yfIk=;
        b=g0/uVIhimUGQGib0/5l4b7vxJsHSXZKZucicSckrwttiHrf+A2BX6mcAJd+8Js7wrq
         sGH2Zep0ytOhcFgubsLu6+0joIPaV4LwioiWfEOP2FGNtSMI+GLQXbIwW4+R085UuKie
         VOCBv8E/C2SMFEcof1eu+jwkwk5AmFJkDGrfumI/bCpmP2dXN25ZAKjtN98dngOrQNJH
         hUVZuWUqvgderIDNWYsKqydNA0aigoKH9JwEgh9k3QAY17P5kq1dzVOt3CEPEN6xvgL2
         SwraI12QHOOHRAj4wxJPD0apL56aQIOgPnL13byjCb5rc2Mk1t7PFF66agy4EQKU6PDV
         uvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=r1rcGz3oiI36OObFHrfowwldn52EAu3Sn/GxYj8yfIk=;
        b=do523x+fz9kwtt9Fl5vra5zWsclGvazyTUaKAGyfyNeWd2qIS5MpuhcXWLgpvedqJg
         ApItmwAougr0F8QSTx63iOg+FSH0WDDjt2BMRM9p5y3ztnUXGYlyUIXGFaFt6R/uqow8
         CWquK82xsQNh2+O5marrbLq+hMuHBuFddGl4xETN/pSaBaa5R70C8D8SSTIzmsuJb5WL
         9WRwc51zYNcVrBBRHPy/hZ2+uXeKCkZ4hjam6XCCouHG78MGC/hdzV2uWCu1gWzrRUd+
         HpindzXA+SnNfLYPlm36StXdVQNVSc1wgHwjD25vn+5qQlbbaY0tf/ZqzD4GD7anlEJz
         h68w==
X-Gm-Message-State: AOAM530rdDsTRjKdBjh8WZFxr3kBLSvDSOWFEvfQiCHYVrtsL2VosQA6
        5rV5VipySZDMWXUwy7ZcuOI=
X-Google-Smtp-Source: ABdhPJxFb5DuKij5xly0ce1fdCDQmJWKtLpC7mX6OP69dCDh5Wvks7JPw5vAjhxVeZqSieFx1QjhYA==
X-Received: by 2002:a05:620a:458a:: with SMTP id bp10mr2005569qkb.278.1644620691269;
        Fri, 11 Feb 2022 15:04:51 -0800 (PST)
Received: from [100.120.46.244] ([38.146.57.250])
        by smtp.gmail.com with ESMTPSA id v5sm12579082qkp.70.2022.02.11.15.04.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 11 Feb 2022 15:04:49 -0800 (PST)
Message-ID: <6206eb91.1c69fb81.b9642.5f22@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re:LOAN OFFER FOR 2022 3% PER MONTH
To:     Recipients <benbernanki@gmail.com>
From:   benbernanki@gmail.com
Date:   Fri, 11 Feb 2022 23:03:52 +0000
Reply-To: benbernank01@gmail.com
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day to you all I'm George Stacey from AUSTRALIA the loan manager, this=
 is to inform everyone that we are now offering loan to the need or busines=
s funding as a result of COVID-19 damages with 3% rate per
month, we offer business loan,car loan,investment loan or loan to pay off y=
our bills, contact us with your Full =


Name:
Phone Number:
Amount Needed:
Duration:
Address:
Country:
Occupation:
Gender:

whatsapp us on +61-488-872-039 for easy conversation

George Stacey
