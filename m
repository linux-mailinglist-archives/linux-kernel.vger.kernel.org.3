Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357584E6050
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbiCXI3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiCXI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:29:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C79BAF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:27:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d5so6765939lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xoSPbru0hWPpcXk1HoCSVQlCJx8nsIwdNqAcwd/eBCs=;
        b=O8sqEW3QeR+Ilzqg6YCA/YTsGiMqAX3IJ/dRmE8ukPPJ14WfYsBBXbXpIpf5YPqtLg
         qQ7Fx4c/YMf45FZn2hatzYrIkCJ5gzfqdagu4XodwI8J3/7xOahXpZqg3gFydlXJwPdj
         5yFifdG8OaVMWSIyZhrPJ53oI0HE6ptoQL9q1tfoi+KRcDeQt5KEbbk86EjYwq2gD+To
         ZLj0xECgTLFpSPyZp8yxGC5mepcPzZTPwir+sXmkA6CX3NAl0UTAHnxGlUNAWV0ykDzu
         qjFrDws0hSGYYXU9kwz00i3bmiazKcX/f511L+jLFCctIztd2Bta22BlvIXlub9Y0qOU
         QQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xoSPbru0hWPpcXk1HoCSVQlCJx8nsIwdNqAcwd/eBCs=;
        b=2CWgC6X00GrKqeki3dZFBbZj9MNCZFxeiR5TQL0+l4+0IUFD6GTjidPO24b45s/0Q3
         DyVhtw2AUPyYHiLE3lz+OmYkzTVmnMnuPi2VQJavK2+xZlJ7sWBSN1q5uX2FhpnYFcqJ
         SvJCT9q5SpShLg+zfveBIKrqh5UljzrhnRYHIpIIq6ra6GWbFHhQ126KbU7z3cfNDUDv
         jZ+w7DOYVz1gRk1CKvAHOsa16hMbsBw/ZQxGCNsoGhVyqBhbFEVyrZt4ZCZWnYvV4aBt
         av48lPSP+0+9YiJ+TsT3OlEsKHXCz3shAbl8giyDiBW0BqwuL2zYxmCSOWWeFuRpyz7J
         6IMg==
X-Gm-Message-State: AOAM5319X+nNj3Hk+CGVieRpz3CVrrACO/rId58nDNGEXgLJ86Ts0fIf
        ApUv/fFuf91PYbuxOd2ONQUNwDvjm7jzI+bbZeg=
X-Google-Smtp-Source: ABdhPJxPN6yeeOB28awhzDIE+gRMIWiLnruUA07YY/bs7mXb1WjKYsDDMOZMCYo0qbvcMEcDsELmKhv8TXdFcpZUhVk=
X-Received: by 2002:a05:6512:15a3:b0:44a:54eb:937e with SMTP id
 bp35-20020a05651215a300b0044a54eb937emr2937571lfb.456.1648110464970; Thu, 24
 Mar 2022 01:27:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:285:0:0:0:0 with HTTP; Thu, 24 Mar 2022 01:27:44
 -0700 (PDT)
From:   Eleanor Taylor <militarybase6535@gmail.com>
Date:   Thu, 24 Mar 2022 01:27:44 -0700
Message-ID: <CAKHHXJbBMXHXh1uPY-m=ZTm+oqJk_iSic7qf=Lsn38uzVF-uWg@mail.gmail.com>
Subject: re
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
Hello,
I would like to talk to you

Thanks
