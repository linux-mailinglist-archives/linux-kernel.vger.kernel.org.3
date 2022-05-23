Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473D530DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiEWK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiEWK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:26:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D4F596
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:26:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gh17so14749881ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uc-cl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=z+uM7vIRKv3KK6/ogXLySxrVBPRCNjdMKIe5V0kgmw8=;
        b=uUZ6E7FuKmdb0uF9pdrSh9br6/j3jz3vQbwgvFLfJt7Q/UeKhBkRcgUDuJLRLB6+l5
         /PWS06phmVz8FKOxeechiebTFDx92JBVzWHQAtJRpOG4H8d5edK4l1h9gXvdvLLztfA2
         qDVe8U4JbWOX9twulcuICkyQSEbYvo6xDXLYaG/hHaMmGqSKvP9eRF8sA0mCkaPvXL3m
         XEcCv9ec3+hGOf1+IjXREFIk5cmflORgb6Otj42dUYolZBygP9U3Y7EAY079kfSPWkku
         gpqnWBRO0rj2wSk70Cbn9fIZVJp+4jfAvjP6nHjvGvjARowxgBXqZbYEpTPSbTOaPuNZ
         t85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=z+uM7vIRKv3KK6/ogXLySxrVBPRCNjdMKIe5V0kgmw8=;
        b=wBSKbdgPZgpH78wRh9ChL00uICPdJjwlI5Hi67HP5NhkIIuIfZMPnahZLp81bnMS/s
         DvZ+Eqd9Euv6YIP0YthHXuFV6eQ6FaEi5v0cDEhoNcHVmIUBDpdR7c5L7tnKcDuB8MLb
         0wEnsDQt41Nfby21JMNdMEfE5wzy1GBqHsx0v1/Bq5oA/zug2HVIagikfuKG7KDpaYHf
         N6jjKywWb1vY9B194f1U8qsxnO8wr9fJJ5ScBOPXIOQ2F8YT7dw08qLFBHh/RS737URK
         B0xLFfwJgTQlMVMkxH5haTuPK404ofdX1Ehn5mkz8OKtVILOL//3iLGpgkFJeGfOKyzL
         qXLQ==
X-Gm-Message-State: AOAM530bCmtAynVvYH3CVl3Ww7EsSpvzSGALyVEHTigVDmqTdV9KRUkA
        FNsdvJik0C7UUqX8fJq6GPodQOX+tiVmQwNlfMB2Uw==
X-Google-Smtp-Source: ABdhPJyNVa3vaINTOhg+LmR+ZNZDK3vt0POO9PVxqdrRX1/4e6NXY7vOr/6w88J10j7UfBaV7TiPy8MU9k6fZnugY3E=
X-Received: by 2002:a17:906:f24f:b0:6fe:9b70:6d63 with SMTP id
 gy15-20020a170906f24f00b006fe9b706d63mr17568754ejb.255.1653301560163; Mon, 23
 May 2022 03:26:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:2cc5:b0:153:d95a:3c5d with HTTP; Mon, 23 May 2022
 03:25:59 -0700 (PDT)
Reply-To: stevebrucefss@gmail.com
From:   Steve Bruce Financial Service <camila.toledo@uc.cl>
Date:   Mon, 23 May 2022 13:25:59 +0300
Message-ID: <CALeUmqNYuV67Hv+1JArHojeFd63EOTd+jQ7Rk1HeXZHB4QjM3w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Steve Bruce Financial Service is giving out stress-free loans to new
applicants at a low interest rate of 2%. If interested, kindly apply
in person via stevebrucefss@gmail.com or call +1 (815) 771-5090.
Thanks
