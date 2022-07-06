Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242A15693A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiGFUxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiGFUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:53:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A63F4E;
        Wed,  6 Jul 2022 13:53:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so29118347ejb.6;
        Wed, 06 Jul 2022 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPC/yhfBicbTkni4vtlss9W8xSqhwhJaJcOTmjPfh0o=;
        b=lwg0PHFNAPPG6e06TPmruHtjs7+YR9Wp1EDyfHxJdFrJEd2ToYUYkLtjUVwtyvRu31
         jhCeS821Zb94D3G+7AKE7YkGEvpQA8uPDOfsWI/z0nVHAfi8Nn/0i8psDpIV8+wC1oxc
         6rPfzCXKilO+lzFQ/ABSu4DJdEN3YJDI0Dpd0oMKAuScjgQ21k9z/r8DQlJeyKuGE6XW
         8oCbt1SNeqiwGAFU2WvRUv8/68b1GB202XCHCqrnnToF7t+nTfpUTWS5gwiDW1sRWMTY
         /uQEWrOS0ps2tyfpv/k9CVXSWOEdS+lEPob+Qvd5RXQ2xLk02kzOgh1TbFL0elN7oILn
         nkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPC/yhfBicbTkni4vtlss9W8xSqhwhJaJcOTmjPfh0o=;
        b=g2rx7kdUSt2OSijcF/i/sD8sAH5oAR9MyoKxMsENhUxNzF+l9xGQpq5fvD6M9CBydL
         qQcTFFYgJC0t7Rc9uDXrNXEsieCcySIdIiwylCkDrbvJglYlbmLVsmLCtG773iRh4pFP
         fFUc6SSm/RfydnkBbpx3TAq+SHM//kufxm5UAYpuAY4yC8vQELWxWJ5H0H5dhcduBw20
         dmONQ8crrfUvpmSGQJ8ZvxpEvvB6PCC3G8W+HHAPZY5P9/gQcOKVukvD22beWZWjMxU+
         S75kbjD29ZuH04BQ6llZ7lqlbSZbJsFMbb8iH6vNkWLaiiMeBUxRJrF91U9B9RIzoUvg
         s6TQ==
X-Gm-Message-State: AJIora9Nv9COYQnHRV/LMaucWiqbpbH4iXAmipEVpkkQ9XOfpXYtY8eg
        z0psjPpOzO8WJpu+FgRiazA=
X-Google-Smtp-Source: AGRyM1v4ijRGj37RkVp8PRGE7A61QWZQ6+sovPmwEiF/371QlMaGphMjRoqWQ0BcXbVKp7g8+meo3Q==
X-Received: by 2002:a17:907:160f:b0:726:a7a4:c626 with SMTP id hb15-20020a170907160f00b00726a7a4c626mr41364469ejc.449.1657140805887;
        Wed, 06 Jul 2022 13:53:25 -0700 (PDT)
Received: from reki (87-168-253.netrunf.cytanet.com.cy. [87.228.168.253])
        by smtp.gmail.com with ESMTPSA id d11-20020a1709064c4b00b0070cac22060esm17735511ejw.95.2022.07.06.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 13:53:25 -0700 (PDT)
Date:   Wed, 6 Jul 2022 23:53:22 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        balbi@kernel.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <20220706235322.01f677bf@reki>
In-Reply-To: <YsXQ4hFDVjO+xm3s@kroah.com>
References: <20220706174634.20639-1-mdevaev@gmail.com>
        <YsXQ4hFDVjO+xm3s@kroah.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Wed, 6 Jul 2022 20:13:54 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> You have to document sysfs files in Documentation/ABI/ in order for us
> to be able to accept them.

I've added this and also the documentation for configfs. Submitted as v2 pa=
tch.
