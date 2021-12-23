Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACB47E17D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347702AbhLWKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243143AbhLWKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:34:04 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21141C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 02:34:04 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g17so14979617ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=SKhdgtknuKYN0ojcipde8C0qHw3TX1wov+DvJSuFN6M=;
        b=dI9U8Ws0UFPlnGiVsyE/HdnFxgNcuCriq3ccqi/4Gtd2PgA8JwT4Pcm3kTR63JpqIn
         04/xFpcZB4aMd1RG6toDuxSiLTXvBuKPU7eDrU3UeWfP2au2WozszMl95e6tNrsiyV2M
         MJE0/qLQmThxnfkYQ6eF9jivXyqmv16prQtg9VQdpo12C0pGWYDiFU4sl+5ZB8kc5qCG
         Qz+oi/SGVKqyX+8myxaj/YXT/3mF6yJfS0u8QvMYmXUqucF/HGlOSMDJoELOG325mPpc
         hjM1W3X3MyBpVVs3+ND0pr+3pmXAdHWQqlFOzU+CG/CDFOGbTGlLoksJdkG00sdgz/UE
         hcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=SKhdgtknuKYN0ojcipde8C0qHw3TX1wov+DvJSuFN6M=;
        b=z8SNANGFdiLMBpD98WudxTe1jABTRSSW18jbhRQ7i8GvroXj/1XWOqgpXsXVVN9ZXr
         2pec8g0nDRgcEwtEeJE3XTiLS7aDYWBNr6F0WJfGZ3W+6CQCpzdAguYKYmMExqGuosnD
         m7QIlfkHkL7au5oaeCRqsBoQiaxNCjMf7I0sHwKQgY6IJ3JwuuCoiBoPPe0ICvJ8iYgW
         TCkHEmcFhdilERJst+wIk60Bb0DlkwowBZFq35LSAi5RrJhz+NHvN1OXdpnEs6v0gUNq
         efMPsD4L+PD9JEPM5FaJaP1twvUB9VwUkSOeqYlwfOeGz+C0GSFhZDe6fjcneuRAyRp1
         LTmg==
X-Gm-Message-State: AOAM532nOiOtekMqmqDQlemWOKJ++KxmsJKpgZwJSVsUSRGImDnTa7L1
        9Hlo35ZX/iczhiom6nei8q0QqB4trmCrw1BkPtSsLTXC4Kh5Yg==
X-Google-Smtp-Source: ABdhPJwFrzqw1hu3Wc/LhAknajd0wIgYA1CzY2DhhtE3sWHSjGatzbF4RmCRdnx1VilnPPAvcblMK5V1kFtyO4CVLXg=
X-Received: by 2002:a25:aaaa:: with SMTP id t39mr2196331ybi.201.1640255643146;
 Thu, 23 Dec 2021 02:34:03 -0800 (PST)
MIME-Version: 1.0
Sender: mohameddjibo363@gmail.com
Received: by 2002:a05:7000:5c53:0:0:0:0 with HTTP; Thu, 23 Dec 2021 02:34:02
 -0800 (PST)
In-Reply-To: <CAFu14DvPcmOHn6y4cFBXA2TDDwhzvh7Q5+Ak41oeyeYRaWO5Mw@mail.gmail.com>
References: <CAFu14DvPcmOHn6y4cFBXA2TDDwhzvh7Q5+Ak41oeyeYRaWO5Mw@mail.gmail.com>
From:   camille <camillejackson021@gmail.com>
Date:   Thu, 23 Dec 2021 10:34:02 +0000
X-Google-Sender-Auth: I4R3AEIV-ymKpzaa9wN9thIm2Gk
Message-ID: <CAFu14Ds15Nz59+UG5A-mhn7TEdDPWHpO93fFpDCCtwR6uiryqQ@mail.gmail.com>
Subject: hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you doing today, i hope you are good please respond back to me
now thanks
