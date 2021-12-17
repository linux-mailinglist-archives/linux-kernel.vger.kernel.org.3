Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCF479723
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhLQW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:28:26 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:44748 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLQW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:28:25 -0500
Received: by mail-ot1-f42.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso4573462otj.11;
        Fri, 17 Dec 2021 14:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w0FVigHbSupuS2iOeVxLq4I6AIyzIF2DwIK5997zYiE=;
        b=HoVUWXz0JBLLMHJ0HsLBDGHdXDDu91qsmVxhVWUK5/ycMXWJj7PK8dbwXLf1apTGZ1
         m+s+UeZ/JW9vBXdp2fEGqrE/XNTwO4AJ5OYBhW2enf6BkOpIFvWyBfImFZNCVWBy+Ihe
         gvH7z+Am6o7jTUbEleQO3c5Zw3I/tdln6Hs03fg0ObeZKXcVNoiraTns9wRHc2QVRs6J
         e1b4RETpPqmXrE+ZoRvQ82iKBO5ds7iLNCf16ipvc2GQxhESVDUFplP2pV0aKaxwbVqM
         ik1N2q9UNUZv0hwe8ZvTBdA5IkctHahO6P+CrmKj+YLPG0ArzL3ark+ahzFcG/RXpOxi
         TqKQ==
X-Gm-Message-State: AOAM530xOs3Ox+6opZO8e75xbOBfWPJk2K3WwsBQEHk1nx26LDdsNh1v
        xOrN0WPOrwS4OGzRmYQerw==
X-Google-Smtp-Source: ABdhPJxyzl5fqXhMNvKMBwTNd8zobu66Hnp+wp3/Q9ena3gos2v+Om4OWEKqNrCT65AJBE+xBXIC7w==
X-Received: by 2002:a05:6830:200d:: with SMTP id e13mr3878879otp.109.1639780104674;
        Fri, 17 Dec 2021 14:28:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n11sm1745387oor.9.2021.12.17.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:28:24 -0800 (PST)
Received: (nullmailer pid 3693509 invoked by uid 1000);
        Fri, 17 Dec 2021 22:28:23 -0000
Date:   Fri, 17 Dec 2021 16:28:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: interrupt-controller: Merge BCM3380
 with BCM7120
Message-ID: <Yb0PB2dOGnzC2kSZ@robh.at.kernel.org>
References: <20211217160546.497012-1-f.fainelli@gmail.com>
 <20211217160546.497012-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217160546.497012-3-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 08:05:46 -0800, Florian Fainelli wrote:
> The two bindings are very similar and should be covered by the same
> document, do that so we can get rid of an additional binding file.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../brcm,bcm3380-l2-intc.txt                  | 39 -------------------
>  .../brcm,bcm7120-l2-intc.yaml                 | 31 +++++++++++++--
>  2 files changed, 28 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
> 

Applied, thanks!
