Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3750D51FC9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiEIM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiEIM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:26:43 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A269184311
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652098968;
        bh=yustGOfw6oNT71WmQfTQNYiblyjxN+Vm25SoRTUJDHQ=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=UyGsFUjlbDo7HqK5m4BqJuOhMf7O6O5z4e3WFb6gNPIpHAsawLhBBW4iRxqry6UNB
         KuxRUBimPJOXxXxJ11NiP4Y0PGgCi5FUsnLve267xXENjaxBCl2lIQs4SKkJE8lBS/
         F95YQzS87WVM03hWsFfePL73sCNjWXl2uBBTVgIs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.11.110.3] ([143.244.37.12]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9nxt-1nkTVN0v4v-005uD4 for
 <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 14:22:48 +0200
Message-ID: <51e141aa-1046-edda-580a-30b05f15fa17@gmx.com>
Date:   Mon, 9 May 2022 12:22:47 +0000
MIME-Version: 1.0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Autocrypt: addr=aros@gmx.com; keydata=
 xjMEYmhJvxYJKwYBBAHaRw8BAQdADk5pbZqvkTjYgJNhuhFnEhGm3wf0wlkSvA1WW6e7PUrN
 IUFydGVtIFMuIFRhc2hraW5vdiA8YXJvc0BnbXguY29tPsKPBBMWCAA3FiEEj8ke+4cCTXTh
 Yr4cMvC8tezQK8cFAmJoSb8FCQAnjQACGwMECwkIBwUVCAkKCwUWAgMBAAAKCRAy8Ly17NAr
 x2A1AP9wVrFztQcuTnO/yDzisQyZsRu8kf7zVcEhAqEOdyLiMwEA6duhPI9mrzMpGbrVbv8m
 o0qOdDlsNWLHcFO9p0qxiQnOOARiaEm/EgorBgEEAZdVAQUBAQdA+jFDQNBNlZr55n45Xdis
 baC3LHPn3V7+1FW8hJfOETIDAQgHwn4EGBYIACYWIQSPyR77hwJNdOFivhwy8Ly17NArxwUC
 YmhJvwUJACeNAAIbDAAKCRAy8Ly17NArx9uPAQDCxAWW7bF3RgiG065nEYYyIbqEziys+sPz
 5fDG+HahXAD+IVVf6Lh9DYeivQN12kSEssZhfy2/qHkmzt+69p2f7AI=
Subject: Linux swap file and LUKS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:LNGJv9+PdFZCXYzeb9YEnWhYhhVbbxMjk2uC/QB+S9RgO+mGTbv
 5ysFeu/M392wXx8QegWC5G8C1K96skOqbw6bJgJ0zS3nXd5XhO7vVLn0liSyW2A8VbvmbzM
 pZDuqryjRDIdpzuo4Z3ggwMcfkfD1zI5/4ac5p0mIMRmv57e0PCvLRV69sdSw/4CxOGUSi3
 0Y8ofASaRx60w/CT4upQA==
X-UI-Out-Filterresults: junk:10;V03:K0:fBd6lOt0X1c=:eNvVpbnPIVtSKIK33Tgu0nq4
 I+wvsJAhsOsBACBwYGS8XxtOsOllYLxuzUJ0LRsTvyn26DE2vsacLCX1YVL2ljdlTwKNACyya
 F0ZJGCjDTledUFgcIGQE/pnhHtFK0ED+jvgGdJfK0EUVr8JA/LzQbKjK/0PnpYJWVjGAvk9hC
 tgSxUyY4sw71IZ8w8AuH72pNOsqXtLUok6pQmTxtWPrpawjw/WT+KAzlgAB7EH1C39e0++UqJ
 fQqKuyoNoW2z2anFVJFkYD+28pYw7ehgtIHHi6ER6unHyhx5yxNf10/GwlSgjNcOCEwFQUXFJ
 fhWL/ckz2O70ttwtwh2RL9bnShpcOwETTHodqb4SEe4bOYUCbCh+J70JfbBi6UXjssk/JfYTj
 eDK2hfx95XMPfMF2dO6uA4EsrC1/1i9BAXh7QDuBftUG8zX29CDq3/Gf36FNwghZMnNkMZlQ+
 sUczrppInpNmUfUGnncIkJ4wzKGCFCXWEJcJrTGiF/SVbU55D2BQ7D6sw/aNEco+Zt+glR3Ty
 jJYJO/yhw5eZyJ6oPsqkPxUGFWFVPlDWnE1uRNOPz/5ogZcqgK5FEmfKVOoHw57Q3yMbZ63aO
 ypc1nBOAy6hggl/0pe3EtOYRF3NZ8VWlxb5hfEEY4pXO7oQqaC3YfteVfqVjBJDHbSJ/5hxPK
 du9nfEyu9bcdL7TTl5jU3UAZ6nQmrSjcH/uCm+BGx+uumblU/ynkCFt4v38aF9u4ErIOEr907
 2C7oVoa5JHEj+qcaGDoDLUW+6zY5Ixe4MadP9jY7NujAxzYpuP8IveWjPrdXuGtszsrh9+05X
 QpPdE1EKEz7keYsnQV7C5IVWXpgbAF5zHeZtA6f00umiPvALe0cQHxfnexlRLxjYjqy61JdTh
 B5oi85alRJGgX005Yo142ztjQj7rnLCRPiaF5G+8QBwcydBAfHS/xuVLCmlLY6d7pLy2mSDgU
 6QaBuk0zKewkWdTDa6ImPClIiXEhS+sNNs9PsKKeUqixSDxi/GAa2AGeMBwojNt7Tt6eLsk6s
 cD16x6h9H06vclV9zdgwGUK3+DRlR39m9vcskwpYBFDLlIngPoI9G2CTtGxu68pMyOI2s6pic
 dRGB3iP59VMaMv7uE6V7XYDplpcs5ZsAD
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClRoZSBtYW4tcGFnZSBvZiBzd2Fwb24gc2F5czoNCg0KICAgICBUaGUgc3dh
cCBmaWxlIGltcGxlbWVudGF0aW9uIGluIHRoZSBrZXJuZWwgZXhwZWN0cyB0byBiZSBhYmxl
IHRvIA0Kd3JpdGUgdG8gdGhlIGZpbGUgZGlyZWN0bHksIHdpdGhvdXQgdGhlIGFzc2lzdGFu
Y2Ugb2YgdGhlIGZpbGVzeXN0ZW0uDQoNCkRvZXMgdGhhdCBtZWFuIHRoYXQgaWYgdGhlIHVz
ZXIgaGFzIGEgTFVLUyB2b2x1bWUgd2l0aCBhIHBhcnRpdGlvbiBvbiANCml0LCBpbiB0aGUg
ZW5kIHRoZSBzd2FwZmlsZSBvbiB0aGlzIHBhcnRpdGlvbiB3aWxsIGVuZCB1cCB1bmVjcnlw
dGVkPw0KDQpDb3VsZCBzb21lb25lIHBsZWFzZSBleHBsYWluIGl0IGluIG1vcmUgZGV0YWls
cz8NCg0KUmVnYXJkcywNCkFydGVtDQo=
