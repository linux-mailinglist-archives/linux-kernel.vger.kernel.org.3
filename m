Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF34C56A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiBZPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiBZPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:36:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986DC43
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:35:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h17so1645870plc.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=X5y2PHvNm0mstyqjm8XDlryceXqrmP2cJsgQ/yskXgL1DE9pQVoDo+6CYDtxJBs4kh
         09wzD/Ery39Q0JJaUF+lXpy+rukpBOkqQsCxwg/ejb5t/m3GRrOHwyQfdI1jrUPPhBcK
         QWnjyjaNKOGs4xWcTdjoZLwXBhrwhilGu6BRerbF1dgTUgSLG2IgbAdRgaLJ/p3r8LNO
         n3KOFBD1oVCV5o5vEO9n1Tb2g+HvGfC5lwotfb5b4qo9yK67tYvLeifhgFAT5nocs89V
         FXE58qVNaG3xeaLbLAvUFrO4GG+ahq42cgxyZLLWPzTbbkqWwF2lNdiT2XT0r8RHwpXW
         OOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=xCWe1ckOTnH02kT+txFLtwWw22ple8wcD1xntTKlJf0dNclfF5f2b6RvQ9Gc6jwl4n
         oqgNxAMGUStEeyVz6PW7qOkAjG9iRfPha0SN/BGr0Elcpo/RlQc0QrLvyZAv4IlOUsRE
         USooPVMs+H8RvyH/JWbcitrXhgiYDtCkEAg0fBP6TShSPbf1jWyQ7/IveztJiY5p1oAN
         HsYiWisSLPvBnyjeeUXpweCCSQWXwnupB5ZO9vIiT0xQqSfjwfhwg2SnyMmVKbJqq2oK
         yJ9P9FYRUQLxezRNvFyq2JTu2wBeapRmjG8CZOBvp1hihQUqLnGYwp3NbmRGm08+CWHL
         PCYw==
X-Gm-Message-State: AOAM531Cbar9d0IMU07IeK5OlKfOonypU0ojCPZuqu8996O6VBqyiB5C
        IFxEa721v86iw6UiTm1w8UVxrhRFT7gDhVzr1uRl+PBl4zdhjgyC
X-Google-Smtp-Source: ABdhPJwShCIgjfsnDNs+S50oCDbyNKPRAzVlUceJv32UKuUa0ciAlqhxTQJlVq4MBoqb/cFuEs33+ZxMDMImsdoEJeM=
X-Received: by 2002:a17:90a:f414:b0:1bc:6da5:2dc9 with SMTP id
 ch20-20020a17090af41400b001bc6da52dc9mr8381613pjb.198.1645889750518; Sat, 26
 Feb 2022 07:35:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:7c0b:b0:56:eaa6:efca with HTTP; Sat, 26 Feb 2022
 07:35:50 -0800 (PST)
From:   Ulrica Mica <ulricamica592@gmail.com>
Date:   Sat, 26 Feb 2022 07:35:50 -0800
Message-ID: <CAA3RahDyhS2XT+EGswkXjHWbwMWmQ2yJxv6B0Z+xnOgPxF+gsw@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica
