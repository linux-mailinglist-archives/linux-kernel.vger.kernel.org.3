Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9C47C0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhLUNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhLUNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:32:18 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D46BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:32:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t26so26973722wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=VFAYdUcoAa/RBUsWThLomBm2E0VJ5Yt60qDK5YTAZfk=;
        b=df/ABPFodypo9MFjM4QCmSS40XaK34ZR0ACdM/cwiR5Su5F1hZLsHw05v1t6rkYqCH
         sJHJt7uQZlbdz5UbMRenBbhDTvUBOZQCIh/1av9EgWEp6ofVRdlhJ6/qNgdgf/uierT+
         dgxornKSWewNJLXS2GiHt8JcuI9mpV7YXTw3/Y8JtoS7BBeugl6HsbXTIfIZc4V0M8VW
         2LKQBkZ4Pgyjnak+HJAe/jDjywtleAkWI4el6TxGvzu8aVoNNDiLSvcO6qyoh+zbcb9s
         HJMwAswdR55nDxYgh9CwKEaAcrjGBKiXBz4gxuays4hzQuY9azRofltW7Y+i6itA9GhE
         vHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=VFAYdUcoAa/RBUsWThLomBm2E0VJ5Yt60qDK5YTAZfk=;
        b=B6EFOUFFQYOHyG9eQUYSUEO2x8wvbrtDR0DiUlZHWSbt4AlUUVB78b7foxKWAely/L
         PYy+VELKtzeOZqEc/IPH7cIFFL9L0DyjJkTlUrREVKy5V6YGdwIQsqoNsQG9aBjyNUGW
         yJPV8Egja2Ozqy/987znP3RMEPDNpY+ArDP+Kge+iutG+9khALia/UXiQU4p1Ak//Wrd
         RtLkPRHCxNw5ip5fbTieZ7oYeOaXHwoUkgUmxUf7PyQBqtokvuhodiOdo5zxNVK1Aciq
         Xa+8N6kCpkWZe8DHWnGEjaQ3M80msRh2UACX8SpfWhuhn62b6qC1tw14QQi4I2Xzv+xr
         8K2Q==
X-Gm-Message-State: AOAM533sJsysysBVu+XmZnw1QCnpna9Xl/BjnrV3L0fIP8Ekgojx8fU6
        OagINtpKPNfABc+yjwE9S+4=
X-Google-Smtp-Source: ABdhPJyFm098uR2Ui2mtltDFWVNOOvKSb+EaalTAt4yLlQbbb8QFJv01CnTbz5pjomABeutAFSe5fw==
X-Received: by 2002:adf:82b4:: with SMTP id 49mr2600442wrc.627.1640093536842;
        Tue, 21 Dec 2021 05:32:16 -0800 (PST)
Received: from [192.168.1.80] ([102.64.218.242])
        by smtp.gmail.com with ESMTPSA id p21sm2423603wmq.20.2021.12.21.05.32.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 21 Dec 2021 05:32:16 -0800 (PST)
Message-ID: <61c1d760.1c69fb81.fcd11.b458@mx.google.com>
From:   Rebecca Lawrence <tchabodenoureni@gmail.com>
X-Google-Original-From: Rebecca Lawrence
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <Rebecca@vger.kernel.org>
Date:   Tue, 21 Dec 2021 13:32:19 +0000
Reply-To: ribeccalawrence@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,
My name is Rebecca, I am a United States and a military woman who has never=
 married with no kids yet. I came across your profile, and I personally too=
k interest in being your friend. For confidential matters, please contact m=
e back through my private email ribeccalawrence@gmail.com to enable me to s=
end you my pictures and give you more details about me. I Hope to hear from=
 you soon.
Regards
Rebecca.
