Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D754CCD67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiCDFqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiCDFqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:46:50 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B4179A10
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:46:03 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f5so14803299ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=tz85quh67FIPwRVSouf8UP0jTPfokMJeiqU4Ac4BIHM=;
        b=Pco+iTteeiRCXDDuTGa1j7zSWMHQPajUgjxxVSC4FJZhP4X1Og31f8la+HNGkr9ofX
         eDP72Wxuual6fdr7BVR11fvGFmgRaxV39NS9xnmgesxkTwjVUOX7IH3Yf9qKbX7TSLtK
         bK7FIzKTo5XRECSO7XkV6wkfdypyI8QDIYnnAMjrhIDgCWtzRcvykmHaOVqkxAsTnCUc
         cp7YJyD07jm83V/9ChoYBQYnCYnr8bD2+k3kanrz4l07FCPnVtgItu/RZOKDnJMrGrWw
         OTe9cSq6DlLeENUXeDM0GRJilToKlJ5Mv6PyjOETN7jox//SV4YjByL6M+w3rkpyLXmH
         ShQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=tz85quh67FIPwRVSouf8UP0jTPfokMJeiqU4Ac4BIHM=;
        b=JJ/+/FHbjmcygnbMs/9w0UV8gABfOx3kfoxsKLh9QKIDRwLlv9Cp61f1HeAa/GjQSL
         15GR05ym/uo2aat2QLQ8XQ1TP62+Yc2QSf+AmhB4GDM+evRnll6LB1VOtQJVmJzEByAB
         iUvCgwvYmD15xujd0hquDUFFOXFnIytW449crg0XtYsR1yCoudoUlQIam6+4S7floIyo
         riOHMUCJ+r6ZJUm5di0zTCHBsM16p+leazRMOeIAmX/CXeW6DrKCBp9zseiRFCx9rGbY
         hNij+IXweT6YCVvtbswr3+GTEDz1mwZLjGxqcfu6YsCVZuD5+J7kKTqOc86qPSwtL0oa
         ZKYw==
X-Gm-Message-State: AOAM533CWi3jGCNCUsHpcGyoUmVxVE04aVU1A48AMr9rUcWlrob7Euig
        ZnYa48O2Eh6ExoRoAXjvdHDyl9TsdgYncLV4XW0=
X-Google-Smtp-Source: ABdhPJw2BhQrpotgA5yb5A5hfYFCbY/Ki6RJ4LIedyqTxN5klhi1ZXkN5JWxjc0jAT89ube4tURe+jYndpYYIHlWyso=
X-Received: by 2002:a25:403:0:b0:628:920b:155c with SMTP id
 3-20020a250403000000b00628920b155cmr14885964ybe.377.1646372762778; Thu, 03
 Mar 2022 21:46:02 -0800 (PST)
MIME-Version: 1.0
Sender: ericnony02@gmail.com
Received: by 2002:a26:c509:0:0:0:0:0 with HTTP; Thu, 3 Mar 2022 21:46:02 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Thu, 3 Mar 2022 21:46:02 -0800
X-Google-Sender-Auth: arWlCh4CVX_o8AF8b6-qwXGRzQ0
Message-ID: <CAGscK4EwEQLbU-40GwHw3XPL+aHdeY9Z3UfTLuhUaLe1nAf4=A@mail.gmail.com>
Subject: PLEASE CONFIRM YOUR EMAIL FOR FURTHER DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
