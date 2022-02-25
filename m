Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E24C3B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiBYBmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiBYBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:42:30 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFCF1C9457
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:41:58 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so4448195ooq.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ccU7IhvZ7Els8T+MgAm5NBg76eticrxZgEOij5McKNY=;
        b=aZnae8hft3NMON94gdEexTyrzHiCJO5i7i0mqqIaW+0uvSKM0oVODPWigc7/STwpE9
         840TWt0rPfgrk8iYX209lpBLs+JZv2GtZWc2svkTM2SWl4raDb9SkXL4d2zTpTgzYbPW
         gyYcvjPZzzdSwwRRzdDxEtP0J4sKGJomLbWmWWBNFBWPe1kBt5V+65NdD0DfJ9tJSWIG
         Ll1NhDj7z/jLxjiXCl0rKq0YvCTlyU2M6p/3qjsHGNFcFd4rjW16eO+lMuDgVOhROuqF
         h0Zjnf5gNwRmzTyt4+B170yLmozBTRPDyxgpWkdXAhQt+03Pv/nofhJi6R4gU4gnleyA
         0MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ccU7IhvZ7Els8T+MgAm5NBg76eticrxZgEOij5McKNY=;
        b=kK0dAjoecA6U8tj7KJUdsoFLFzirZnf1gfXMLYVwikVbCZ3EjpAHoEkTjRJs8xF22m
         bNJmFagAqQiBhcg87z9C/DB1U2Hr07iAsX7PVqZxq9pPjaM+WM9ktcEsqKxgQy55kqJh
         4AHHX/jXRVq8ms4GA1p8qnTa+GNXQjcr9OR8kug16lgnzI+RFI5JynBKLukSurfWwi+H
         vLipGB6mIgPmtOcMN1SfOS5IqCPsswQpYFjeoQ7KcQYADV5mb3eeaGCt237EEVNOiXtx
         fKmOks2Z0MfDorP2EZ/pQQGouapy3M0ZYxIhRXHe1SIG9nwuZBxyhgJcdmkMzWvYTrZ0
         09yw==
X-Gm-Message-State: AOAM532PzkVriVJi3LXxZ5TANq0zxeiaTA61iIpt5oo94Qh4CnLkotAb
        xu2i3zOxMpZTMtM+8CZsHi8WNJTTiBHoWdvPvZE=
X-Google-Smtp-Source: ABdhPJzelOLpU8Ppds8hAU5/HqvoJQonKsa/70z0VOq5fEBWtL1d02E4AojrFnCEGIdNsuSVgaNx+f27Q1Uo/dVPt2Y=
X-Received: by 2002:a05:6870:3e0a:b0:cd:8563:f14e with SMTP id
 lk10-20020a0568703e0a00b000cd8563f14emr414798oab.221.1645753317642; Thu, 24
 Feb 2022 17:41:57 -0800 (PST)
MIME-Version: 1.0
Sender: mrfaisalsamae36@gmail.com
Received: by 2002:ac9:40c7:0:0:0:0:0 with HTTP; Thu, 24 Feb 2022 17:41:57
 -0800 (PST)
From:   Hassan Mimi <mimihassan971@gmail.com>
Date:   Thu, 24 Feb 2022 17:41:57 -0800
X-Google-Sender-Auth: udzcKNFpeEl90vAchC8grHhfH78
Message-ID: <CAOkhqep97mfxkH7Rm7gfwyqRRfGEqLt24=J2pO+A4fmdQo27Pw@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs Mimi Hassan and i was diagnosed with cancer about 2 years
ago,before i go for a
surgery  i  have to do this,so  If you are interested to use the sum
of US17.3Million)to help Poor, Less-privileged and  ORPHANAGES and
invest  in your country, get back to me for more information on how
you can  contact the company for where the fund is
Warm Regards,
MRS.MIMI HASSAN
