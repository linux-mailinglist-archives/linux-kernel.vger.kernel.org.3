Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473558517E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiG2OY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiG2OYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:24:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9414D56B8B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:24:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w10so4785723plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:from:to:mime-version;
        bh=UConN5gGUaEKejzmj0/FeH3qdQlU3JzNGuCzI1IImJs=;
        b=ie0Fsxa6BJS/R/ucTt6BbbZY2nH/R5Ghz+cihlgyZHEslUpxe/OsloQHsjd3SC0uhF
         4SfN3XO3t5wYLbuDqlZFoYp2jqMdc1UYyqMpuG2RI4LVjvrkEPQU6SR4NH8o05hd2+28
         5t7fjn7N1IuGIRWr66+aZd9toKEkYoqGSCE/svsE9Actdk7T2vkFHN4mV/lXf4w9xZn7
         FwEipySPT0rFQkTT+BDwB8PXdIAXD8M8C4PZnj0mLwDj1PyBPGjTqDNWHd0z8nc/3R7A
         T8FUiiz04Nu2Ds/ADzMc8UOzANSAa+CYF6WCliga7PaSiKgJhyDl0Exee1QwMsbvKW9g
         4r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version;
        bh=UConN5gGUaEKejzmj0/FeH3qdQlU3JzNGuCzI1IImJs=;
        b=0OkwqKDxC4FuQaZXa8OmTS7nxn35gUEMQ5VTqQABzylPJcExMQDPbjbiUqadA0xxQZ
         ntcB7VYTjkdeSit0UMVendF5z4NAnyerGhROfN5VuPw1EDmooApoBpUpHZUspDwHfgim
         xt2qmKVemxvKw2dQT/jOdtOLTtmWyZJT7duI/nD36Lg8mAR42mzP8LLMmdu4/JJbe2MQ
         67sDV2IVaHlBwbyAZZJf6JOqFybd7OyTocDwAimLMvXgdGD2JnQtqcOM+4zYrg0qOI//
         sxZvo4tLAgKkJ31H0IRmt5nbeOaM+d4xmquHtl6KO1AdY4jQxnvUmzr1fGjqFp8kIZHp
         5Lvg==
X-Gm-Message-State: ACgBeo1avaOeaaJ5sGJlYaO5fNEJd3P4f/QN7vd3YeXRB0Q/E7ICHII2
        b4OjK3fryu6vSocLYm3cI/arVRFxBBI=
X-Google-Smtp-Source: AA6agR7V8NxMV0KCFdI0LcFRIlsaytitehvoL81NcR1G3XKcKSxzn4Rbyr3xZkE5ZMHku4p44tUkRw==
X-Received: by 2002:a17:903:2683:b0:16e:c630:fb2e with SMTP id jf3-20020a170903268300b0016ec630fb2emr666485plb.52.1659104663845;
        Fri, 29 Jul 2022 07:24:23 -0700 (PDT)
Received: from [10.2.0.2] ([185.230.126.2])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b0016daee46b72sm394895plb.237.2022.07.29.07.24.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 07:24:23 -0700 (PDT)
Message-ID: <62e3ed97.170a0220.77fc4.08a7@mx.google.com>
Date:   Fri, 29 Jul 2022 07:24:23 -0700 (PDT)
Subject: Your E Receipt has been renewed on July 25, 202242488611 of item
From:   hdhgyhcjgnhuy57475bhfnch@gmail.com
To:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9033940074199228714=="
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FREEMAIL_DOC_PDF
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--===============9033940074199228714==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

To linux-kernel@vger.kernel.org,

Congratulations! You=C3=A2=E2=82=AC=E2=84=A2re now a part of the GEEK SQUAD f=
amily.
=20
You=C3=A2=E2=82=AC=E2=84=A2ve made a great decision and we=C3=A2=E2=82=AC=E2=
=84=A2re eager to hear about your impression about the SUBSCRIPTION you=C3=A2=
=E2=82=AC=E2=84=A2ve recently purchased.
=20
Find Your 67267869203.

Order Number   : 672545678
Order Date     : 29-JULY-2022
Product Key    : 2FABF-766CDAGH

Product : SUBSCRIPTION RENEWED FOR THE MONTH OF JULY 2022
Quantity Term Price  (US) : $349.99

Grand Total: $349.99
For any queries like installations, error or cancellation regarding this orde=
r feel free to contact us at (+1 888 314 7528). We hope for a positive reply.

--===============9033940074199228714==
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Bill42488611.pdf"
MIME-Version: 1.0

JVBERi0xLjQKMSAwIG9iago8PAovVGl0bGUgKP7/KQovQ3JlYXRvciAo/v8AdwBrAGgAdABtAGwA
dABvAHAAZABmACAAMAAuADEAMgAuADYpCi9Qcm9kdWNlciAo/v8AUQB0ACAANAAuADgALgA3KQov
Q3JlYXRpb25EYXRlIChEOjIwMjIwNzI5MTQyNDIyWikKPj4KZW5kb2JqCjMgMCBvYmoKPDwKL1R5
cGUgL0V4dEdTdGF0ZQovU0EgdHJ1ZQovU00gMC4wMgovY2EgMS4wCi9DQSAxLjAKL0FJUyBmYWxz
ZQovU01hc2sgL05vbmU+PgplbmRvYmoKNCAwIG9iagpbL1BhdHRlcm4gL0RldmljZVJHQl0KZW5k
b2JqCjYgMCBvYmoKPDwKL1R5cGUgL0NhdGFsb2cKL1BhZ2VzIDIgMCBSCj4+CmVuZG9iago1IDAg
b2JqCjw8Ci9UeXBlIC9QYWdlCi9QYXJlbnQgMiAwIFIKL0NvbnRlbnRzIDcgMCBSCi9SZXNvdXJj
ZXMgOSAwIFIKL0Fubm90cyAxMCAwIFIKL01lZGlhQm94IFswIDAgNTk1IDg0Ml0KPj4KZW5kb2Jq
CjkgMCBvYmoKPDwKL0NvbG9yU3BhY2UgPDwKL1BDU3AgNCAwIFIKL0NTcCAvRGV2aWNlUkdCCi9D
U3BnIC9EZXZpY2VHcmF5Cj4+Ci9FeHRHU3RhdGUgPDwKL0dTYSAzIDAgUgo+PgovUGF0dGVybiA8
PAo+PgovRm9udCA8PAo+PgovWE9iamVjdCA8PAo+Pgo+PgplbmRvYmoKMTAgMCBvYmoKWyBdCmVu
ZG9iago3IDAgb2JqCjw8Ci9MZW5ndGggOCAwIFIKL0ZpbHRlciAvRmxhdGVEZWNvZGUKPj4Kc3Ry
ZWFtCnic03cPTlRIL1bQdw4uUEiG0s7BXAZ65qYGEKAAgrrIAkYWelC2goWhMZStkJzLVahQyBXI
FQgkYTRIby6XuaG5HkiNoSmQm4PMNTQwMdMzszS0tACKG6BzQYozuMK1FPK4kAxWCOQCABQNJg4K
ZW5kc3RyZWFtCmVuZG9iago4IDAgb2JqCjEwOQplbmRvYmoKMiAwIG9iago8PAovVHlwZSAvUGFn
ZXMKL0tpZHMgClsKNSAwIFIKXQovQ291bnQgMQovUHJvY1NldCBbL1BERiAvVGV4dCAvSW1hZ2VC
IC9JbWFnZUNdCj4+CmVuZG9iagp4cmVmCjAgMTEKMDAwMDAwMDAwMCA2NTUzNSBmIAowMDAwMDAw
MDA5IDAwMDAwIG4gCjAwMDAwMDA4MzQgMDAwMDAgbiAKMDAwMDAwMDE1NyAwMDAwMCBuIAowMDAw
MDAwMjUyIDAwMDAwIG4gCjAwMDAwMDAzMzggMDAwMDAgbiAKMDAwMDAwMDI4OSAwMDAwMCBuIAow
MDAwMDAwNjMyIDAwMDAwIG4gCjAwMDAwMDA4MTUgMDAwMDAgbiAKMDAwMDAwMDQ1NyAwMDAwMCBu
IAowMDAwMDAwNjEyIDAwMDAwIG4gCnRyYWlsZXIKPDwKL1NpemUgMTEKL0luZm8gMSAwIFIKL1Jv
b3QgNiAwIFIKPj4Kc3RhcnR4cmVmCjkzMgolJUVPRgo=

--===============9033940074199228714==--
