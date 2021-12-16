Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91CD47711F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhLPLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:53:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50132 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhLPLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:53:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AB41B823AF;
        Thu, 16 Dec 2021 11:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F82C36AE3;
        Thu, 16 Dec 2021 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639655585;
        bh=kutu15ERamquSNkAlx1bDeUoCF/UYHWL53rUHvMX9Fs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dy2jQEMV/6qhdfMxYGoMk3fxP/8MUfJbRzw8gHQySz0QH3zyZRHenVLGijH9fyhx+
         n1poY8RFt+g6d2Z9u+PU8/pZS4oVDNJgRdvs16n+NXQULs3Q0WZr2wdZ1aSAnS9jIG
         T/h99G3hwgzWyhNcURgcUbvzQAvob7QhC7VJwood8MD1JePK10cg6x4sFjisont3ts
         hcQoVC3GKWNUKJ7PqsAr5VO4GNzsl7nX8eUuGEImuqMpc/A3DZE78Jk4MxW6bkeaTc
         7Z4gQd1LymaLhnLuqZ7/8cfdQYC2SYkwAx1EM/bWP12RqISEidaw8jZUDJlVOWRyHZ
         xSajFQnvX9Uqw==
Received: by mail-oo1-f50.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso6842717ood.13;
        Thu, 16 Dec 2021 03:53:05 -0800 (PST)
X-Gm-Message-State: AOAM532Y9CaCyXzpxmVL4h6odr65K3Mw6jAM+x+eCNBsDbEraicaiRaC
        mXb0pCCpToWnZFstszg+ESNDYTW0mxnMXOHBltU=
X-Google-Smtp-Source: ABdhPJy7gZKCLdC21/xK+PNfiB9yQVQzSFUsRma50bn2AQjzfMW4vD2rV9nkaZOTdtRE0NE9NTMra70dag3UXjY6JQM=
X-Received: by 2002:a05:6820:622:: with SMTP id e34mr10975602oow.19.1639655584417;
 Thu, 16 Dec 2021 03:53:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Thu, 16 Dec 2021 03:53:04
 -0800 (PST)
In-Reply-To: <20211216103721.1686600-1-marcos@orca.pet>
References: <20211216103721.1686600-1-marcos@orca.pet>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 16 Dec 2021 20:53:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9w7BBGBn_ZuSNZ-KVL_YLUW0_TFAKXSRr=YAdETsMv6A@mail.gmail.com>
Message-ID: <CAKYAXd9w7BBGBn_ZuSNZ-KVL_YLUW0_TFAKXSRr=YAdETsMv6A@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1
To:     Marcos Del Sol Vives <marcos@orca.pet>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-12-16 19:37 GMT+09:00, Marcos Del Sol Vives <marcos@orca.pet>:
> According to the official Microsoft MS-SMB2 document section 3.3.5.4, this
> flag should be used only for 3.0 and 3.0.2 dialects. Setting it for 3.1.1
> is a violation of the specification.
>
> This causes my Windows 10 client to detect an anomaly in the negotiation,
> and disable encryption entirely despite being explicitly enabled in ksmbd,
> causing all data transfers to go in plain text.
>
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>
> Cc: linux-kernel@vger.kernel.org
> Cc: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
