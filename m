Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DA5635AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiGAOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiGAOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:34:36 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2276B802;
        Fri,  1 Jul 2022 07:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656685799; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=WytGit7/VJVzWYVcDuphLiPxX5pT2qBET0QJ9Dd0CLbcFUG7LhWniefl1jAX4d3XLFkbsJTep5InNU5XVdGR1RC57jHOvXlbPt7lG3ukDuFiiu9u0ARs8x2VnVEqztUi++8ZoHknudjQSHsCZd/RdtFFZHJJKsamFIo1gAVLkiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1656685799; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=afITDBJUJm7jKiQgATQjaUMg82FcalVO6iB2x0vBPY0=; 
        b=CKwYabmYsBX/aJg2XDvQkmu3dczm8sYcRIBlt4+/aAcp1BBtmkeTbDQpOEYfZ3Rxg3FqG9DBqHDgqOcSUJTJN8+hrH8BafHgvePMU8GLnV7fxGLYRITx65S/StNpVR33QErTujJYLRjPu9tj2U+t9ogckaPNPgGwTNB5tATZUB4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656685799;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=afITDBJUJm7jKiQgATQjaUMg82FcalVO6iB2x0vBPY0=;
        b=ZiDJF40QzmHiaKP/ALzgvMTGJNMhVWGK8k5Bin2QCm5HLU92J5mSo1g7p1zBZFDW
        gbPy/LDQDWGnD7LBXzjb62hKzp0JQ59+6fRqVf92uHGECViJ8NKbtfI0R5hLzoidBl9
        TwpiKT5AvTK/Rhskt++Aq8A/JeD6H005atm5OK2E=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1656685787788483.58861760110744; Fri, 1 Jul 2022 19:59:47 +0530 (IST)
Date:   Fri, 01 Jul 2022 19:59:47 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Shuah Khan" <skhan@linuxfoundation.org>
Cc:     "linux-s390" <linux-s390@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <181ba2afa51.7d123db0789809.1834230085722405669@siddh.me>
In-Reply-To: <390aca1b-3b48-e0c1-07a1-ec8c29f0b8af@linuxfoundation.org>
References: <20220628064621.14427-1-code@siddh.me> <390aca1b-3b48-e0c1-07a1-ec8c29f0b8af@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Add tools/testing/crypto/chacha20-s390/
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2022 05:30:27 +0530  Shuah Khan <skhan@linuxfoundation.org> wrote
> Doesn't look like you cc'ed the maintainers - please do and resend.

Sorry for not doing so. I will resend now.

Thanks,
Siddh
