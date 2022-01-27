Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE849E1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiA0MCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiA0MCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:02:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF38C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:02:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n8so4892955lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XhtvzHGLBTlHpgrsVt3OxS8UVSEEinBsRKFFK6183gw=;
        b=IHkYvyCfXxjCcI/B0J026dwMFYf3c1NuWIoEe38pk6d2ACqUDabo0owYPl2fJU4TeY
         swIDSeuC9cvxhEh1N0D7O3C+9+eLXXadIZFM+VJDVn/2bo+qkdTvkwJ5a1SNy5xl4cJW
         Daglgp/Z41BMgAzF+nCBQr+FFkZS1RTiP2o/17fs/CzJfTDNveN4n7drY7xEkrnS6SSr
         gnKRmNY9Hjqz1kRWcSPKAArICMYDFs+YjSne6STSjDbfVX6andi7fZFcboCYZJOX/4LG
         D4Gi6u1I4nZB64AcFlKLqd0/TBXdffzMye/l75QKVW+aXuuf+It4zwxyvbJve3qmO2oA
         YXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XhtvzHGLBTlHpgrsVt3OxS8UVSEEinBsRKFFK6183gw=;
        b=TnGTRQh0pVM0rRoETXbMyeORJ1VIdWK0F2CvktVP/9ruz5RhkDPps2KgCMShkoyRlT
         S42RqNho2vvn1z0uyt2XIAs2rPXajDvEgGBGPYklagB5agZ66b21aEbwB/qbUdVVKP4x
         mmXZaolg9WF3/QHiRDtnbUkfiv6Ww4Bqz6jkAAwIuE99fH6L1TDlB+kmHgutrEfstbc8
         qkWH/37+lbIweeEXuvYiepF3zP3WerkbKtD2lx52PeDFylh+xNBlUP26ZCSdXfw83SzP
         le7UTJ72qXwK6lv2pDJws/AJ0U1zt6lVHrfXNv5VTGUxKAY8RxDKR+YA4r/xLT/WXR8E
         MSlA==
X-Gm-Message-State: AOAM531JnVd/ICQwpXC3gOyQoGehJqcvZVUzAS12lp2BivEqIQGSiVrK
        pSljETSXhaNbQ0wfMqGhdK6L6g==
X-Google-Smtp-Source: ABdhPJyQHW7VSjqdBiGLJfRPwoDOEyTxeMELd3EAIlBU/fag1qkrSPxfGQ95u+TaDFjU7N8K6tDA6A==
X-Received: by 2002:a05:6512:238c:: with SMTP id c12mr2612318lfv.333.1643284928123;
        Thu, 27 Jan 2022 04:02:08 -0800 (PST)
Received: from [192.168.219.3] ([78.8.192.131])
        by smtp.gmail.com with ESMTPSA id n20sm835673ljg.136.2022.01.27.04.02.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:02:07 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:02:02 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@embecosm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kbuild: remove include/linux/cyclades.h from header file
 check
In-Reply-To: <20220127073304.42399-1-gregkh@linuxfoundation.org>
Message-ID: <alpine.DEB.2.20.2201271201010.11348@tpp.orcam.me.uk>
References: <20220127073304.42399-1-gregkh@linuxfoundation.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022, Greg Kroah-Hartman wrote:

> The file now rightfully throws up a big warning that it should never be
> included, so remove it from the header_check test.

 Thanks, I wasn't aware we have this stuff.

  Maciej
