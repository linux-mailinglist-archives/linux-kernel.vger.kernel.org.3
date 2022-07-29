Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB1585150
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiG2OLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiG2OLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:11:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A941D26
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:11:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f11so4112022pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:from:to:mime-version;
        bh=qfKreIyAFjzfLO9XJ6DZC6Mrw3Y5mQ93ywV9br3k1l4=;
        b=pNtVyL9yUceHZvN8RSTUlnpfsiBm7iTapa219s+eXct4wbGnL2IvO1ZOK3PgSLlI/7
         NoFJW9rmlwSgi/hhnI4rE7p9D9ns26XjCv0VTreZV0drwIxELCt0CsNCV4TUV3+/t8HY
         l5r1/YyRPP3BXc8IoeipwfQNcV+wvl0OeguIETPpFkwvmo5PqVDxJiUmEte2emhLSR90
         RcFGa4vSgwxQH38wczoZMFI7UWbvV4iQk34EORvUOMAqgSHSAc6udVwOSG5KyoETySfn
         sTrhoKMIuogWO6BQhxf9mBLzoh28ECziNRLZBLrSFhUx0HI+FgVCyDmaZ5YKgM7JzVck
         hMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:subject:from:to:mime-version;
        bh=qfKreIyAFjzfLO9XJ6DZC6Mrw3Y5mQ93ywV9br3k1l4=;
        b=xq64B63D3DAFFT6Ocu3qnnSISG5kbc6GYr4P9awhckNR8DZKD6cAzIJDbqKQ6SYLtS
         WgrEHaamHdZSqNzqAKkVI61sABqotG34U2ZcZPWzw/G7ni9P+5993kBIWQ5iKWRcBSvQ
         TREILlaOWq7aaIMszD6dD9Yf3DkYdyUm3FHPAV8/HA+6wLiyofn+CcWN/Mv2kwpumqwM
         MHASe983kFuEca5G0ExTajSZj2aAeMN4a5oHgPNw9auWMp2cxWERN6TyKjxNUwXkG1Z/
         A+sjIR4GkIjAwzNvYVqDKrR3BV67cC3o3eVGjPbyL7i8xjWUiRqK54Zy7N2dZIZIvOo3
         PXIA==
X-Gm-Message-State: AJIora9BXTW9Q2RK3xN079nJ951J5jX67GWnNp3pGcBSSGv4+9UlRib2
        Y69pzCESW20REkQRSVycjkWquU8PFcA=
X-Google-Smtp-Source: AGRyM1u8WyJ+Mj855kjzfqI75M+/mwZ/Gt9wo9HQiNhn9Ay8MyRQdcEMRjbF56df/lCspjdVPKveng==
X-Received: by 2002:a63:5325:0:b0:41b:59f1:79d2 with SMTP id h37-20020a635325000000b0041b59f179d2mr3255074pgb.52.1659103871571;
        Fri, 29 Jul 2022 07:11:11 -0700 (PDT)
Received: from [10.2.0.2] ([185.230.126.2])
        by smtp.gmail.com with ESMTPSA id bc12-20020a656d8c000000b0041b5b929664sm2573266pgb.24.2022.07.29.07.11.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 07:11:10 -0700 (PDT)
Message-ID: <62e3ea7e.650a0220.33e34.397d@mx.google.com>
Date:   Fri, 29 Jul 2022 07:11:10 -0700 (PDT)
Subject: Your E Receipt has been renewed on July 25, 202282992033 of item
From:   hdhgyhcjgnhuy57475bhfnch@gmail.com
To:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8347847731552974127=="
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FREEMAIL_DOC_PDF
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--===============8347847731552974127==
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
Find Your 67287863330.

Order Number   : 672545678
Order Date     : 29-JULY-2022
Product Key    : 2FABF-766CDAGH

Product : SUBSCRIPTION RENEWED FOR THE MONTH OF JULY 2022
Quantity Term Price  (US) : $349.99

Grand Total: $349.99
For any queries like installations, error or cancellation regarding this orde=
r feel free to contact us at (+1 888 314 7528). We hope for a positive reply.

--===============8347847731552974127==
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Bill82992033.pdf"
MIME-Version: 1.0

JVBERi0xLjQKMSAwIG9iago8PAovVGl0bGUgKP7/KQovQ3JlYXRvciAo/v8AdwBrAGgAdABtAGwA
dABvAHAAZABmACAAMAAuADEAMgAuADYpCi9Qcm9kdWNlciAo/v8AUQB0ACAANAAuADgALgA3KQov
Q3JlYXRpb25EYXRlIChEOjIwMjIwNzI5MTQxMTA4WikKPj4KZW5kb2JqCjMgMCBvYmoKPDwKL1R5
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

--===============8347847731552974127==--
